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

    config.active_insights = ActiveSupport::OrderedOptions.new

    initializer "active_insights.config" do
      config.active_insights.each do |name, value|
        ActiveInsights.public_send(:"#{name}=", value)
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
        next if Rails.env.development? ||
          ActiveInsights.ignored_endpoint?(payload)

        Thread.new do
          ActiveRecord::Base.connection_pool.with_connection do
            ActiveInsights::Request.
              setup(started, finished, unique_id, payload).
              create!(controller: payload[:controller],
                      action: payload[:action], format: payload[:format],
                      http_method: payload[:method], status: payload[:status],
                      view_runtime: payload[:view_runtime])
          end
        end
      end
    end
  end
end
