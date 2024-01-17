# frozen_string_literal: true

require "rubystats"

module ActiveInsights
  class Seeder
    def initialize(date, rpm, p50, p95, p99)
      @date = date
      @rpm = rpm
      @p50 = p50
      @p95 = p95
      @p99 = p99
    end

    def seed
      ActiveInsights::Request.insert_all(seed_attributes)
    end

    def find_percentile(sorted_data, percentile)
      sorted_data[(percentile * sorted_data.length).ceil - 1]
    end

    private

    attr_reader :date, :rpm, :p50, :p95, :p99

    def seed_attributes
      24.times.flat_map do |hour|
        60.times.flat_map do |min|
          response_times.map { |duration| attributes(hour, min, duration) }
        end
      end
    end

    def response_times
      Array.new(rpm) do
        p50 + (beta_distribution.rng * (p95 - p50))
      end.select { |time| time <= p99 }
    end

    def beta_distribution
      @beta_distribution ||= Rubystats::BetaDistribution.new(2, 5)
    end

    def sample_controller
      ["AppsController#show", "OrganizationsController#show",
       "AgentController#create", "AppComponentsController#index",
       "BadgesController#show", "ContactController#create",
       "AppsController#update"].sample.split("#")
    end

    def attributes(hour, min, duration)
      sample_controller.then do |controller, action|
        started_at = date.dup.to_time.change(hour:, min:)

        default_attributes.merge(controller:, action:, duration:, started_at:,
                                 finished_at: started_at + (duration / 1000.0))
      end
    end

    def default_attributes
      { created_at: Time.current, updated_at: Time.current, format: :html,
        http_method: :get, uuid: SecureRandom.uuid }
    end
  end
end
