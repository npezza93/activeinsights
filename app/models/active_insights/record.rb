# frozen_string_literal: true

module ActiveInsights
  class Record < ApplicationRecord
    self.abstract_class = true

    connects_to(**ActiveInsights.connects_to) if ActiveInsights.connects_to

    scope :with_durations, lambda {
      case connection.adapter_name
      when "SQLite"
        select("JSON_GROUP_ARRAY(duration) AS durations")
      when "Mysql2", "Mysql2Spatial", "Mysql2Rgeo", "Trilogy"
        select("JSON_ARRAYAGG(duration) AS durations")
      when "PostgreSQL"
        select("JSON_AGG(duration) AS durations")
      end
    }
    scope :minute_by_minute, lambda {
      case connection.adapter_name
      when "SQLite"
        group("strftime('%Y-%m-%d %H:%M:00 UTC', " \
              "'active_insights_requests'.'started_at')")
      when "Mysql2", "Mysql2Spatial", "Mysql2Rgeo", "Trilogy"
        group("CONVERT_TZ(DATE_FORMAT(`active_insights_requests`.`started_at`" \
              ", '%Y-%m-%d %H:%i:00'), 'Etc/UTC', '+00:00')")
      when "PostgreSQL"
        group("DATE_TRUNC('minute', \"active_insights_requests\"." \
              "\"started_at\"::timestamptz AT TIME ZONE 'Etc/UTC') " \
              "AT TIME ZONE 'Etc/UTC'")
      end
    }
    scope :select_started_at, lambda {
      case connection.adapter_name
      when "SQLite", "Mysql2", "Mysql2Spatial", "Mysql2Rgeo", "Trilogy"
        select(:started_at)
      when "PostgreSQL"
        select("DATE_TRUNC('minute', \"active_insights_requests\"." \
               "\"started_at\"::timestamptz AT TIME ZONE 'Etc/UTC') " \
               "AT TIME ZONE 'Etc/UTC' as started_at")
      end
    }

    before_validation do
      self.duration ||= (finished_at - started_at) * 1000.0
    end

    def agony
      parsed_durations.sum
    end

    def parsed_durations
      return unless respond_to?(:durations)

      @parsed_durations ||=
        if durations.is_a?(Array) then durations
        else
          JSON.parse(durations)
        end.sort
    end

    def pretty_started_at
      started_at.strftime("%-l:%M%P")
    end

    def p50
      percentile_value(0.5)
    end

    def p95
      percentile_value(0.95)
    end

    def p99
      percentile_value(0.99)
    end

    private

    def percentile_value(percentile)
      parsed_durations[(percentile * parsed_durations.size).ceil - 1].round(1)
    end
  end
end
