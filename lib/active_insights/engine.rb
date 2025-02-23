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

    initializer "active_insights.job_subscriber" do
      ActiveSupport::Notifications.
        subscribe("perform.active_job") do |_name,
          started, finished, unique_id, payload|
          next unless ActiveInsights.enabled?

          ActiveInsights::Job.setup(started, finished, unique_id, payload)
        end
    end

    initializer "active_insights.request_subscriber" do
      ActiveSupport::Notifications.
        subscribe("process_action.action_controller") do |_name,
          started, finished, unique_id, payload|
        next if ActiveInsights.ignored_endpoint?(payload) ||
          !ActiveInsights.enabled?

        Thread.new do
          Rails.application.executor.wrap do
            ActiveInsights::Request.
              setup(started, finished, unique_id, payload)
          end
        end
      end
    end
  end
end
