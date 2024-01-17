# frozen_string_literal: true

module ActiveInsights
  class Engine < ::Rails::Engine
    isolate_namespace ActiveInsights

    def self.importmap
      @importmap ||=
        Importmap::Map.new.tap do |mapping|
          mapping.draw(Engine.root.join("config/importmap.rb"))
        end
    end

    initializer "active_insights.importmap", before: "importmap" do |app|
      app.config.importmap.paths <<
        Engine.root.join("config/initializers/importmap.rb")
    end

    initializer "active_insights.subscriber" do |_app|
      ActiveSupport::Notifications.
        subscribe("process_action.action_controller") do |_name,
          started, finished, unique_id, payload|
        next if Rails.env.development?

        Thread.new do
          ActiveRecord::Base.connection_pool.with_connection do
            ActiveInsights::Request.create!(
              started_at: started, finished_at: finished, uuid: unique_id,
              duration: (finished - started) * 1000.0,
              controller: payload[:controller],
              action: payload[:action], format: payload[:format],
              http_method: payload[:method], status: payload[:status],
              view_runtime: payload[:view_runtime],
              db_runtime: payload[:db_runtime]
            )
          end
        end
      end
    end
  end
end
