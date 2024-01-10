# frozen_string_literal: true

module ActiveMetrics
  class Engine < ::Rails::Engine
    isolate_namespace ActiveMetrics

    class << self
      attr_accessor :configuration
    end

    class Configuration
      attr_reader :importmap

      def initialize
        @importmap = Importmap::Map.new
        @importmap.draw(Engine.root.join("config/importmap.rb"))
      end
    end

    def self.init_config
      self.configuration ||= Configuration.new
    end

    def self.configure
      init_config
      yield(configuration)
    end

    initializer "active_metrics.importmap", before: "importmap" do |app|
      app.config.importmap.paths << Engine.root.join("config/initializers/importmap.rb")
    end

    initializer "active_metrics.subscriber" do |_app|
      ActiveSupport::Notifications.
        subscribe("process_action.action_controller") do |_name,
          started, finished, unique_id, payload|
        Thread.new do
          ActiveRecord::Base.connection_pool.with_connection do
            ActiveMetrics::Request.create!(
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

ActiveMetrics::Engine.init_config
