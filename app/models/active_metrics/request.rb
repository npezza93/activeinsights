# frozen_string_literal: true

module ActiveMetrics
  class Request < ::ActiveMetrics::Record
    scope :with_durations, lambda {
      case connection.adapter_name
      when "SQLite", "Mysql2", "Mysql2Spatial", "Mysql2Rgeo", "Trilogy"
        select("GROUP_CONCAT(duration) AS durations")
      when "PostgreSQL"
        select("STRING_AGG(duration, ',') AS durations")
      end
    }
    scope :group_by_minute, lambda {
      case connection.adapter_name
      when "SQLite"
        group("strftime('%Y-%m-%d %H:%M:00 UTC', " \
              "'active_metrics_requests'.'started_at')")
      when "Mysql2", "Mysql2Spatial", "Mysql2Rgeo", "Trilogy"
        group("CONVERT_TZ(DATE_FORMAT(`active_metrics_requests`.`started_at`" \
              ", '%Y-%m-%d %H:%i:00'), 'Etc/UTC', '+00:00')")
      when "PostgreSQL"
        group("DATE_TRUNC('minute', \"active_metrics_requests\"." \
              "\"started_at\"::timestamptz AT TIME ZONE 'Etc/UTC') " \
              "AT TIME ZONE 'Etc/UTC'")
      end
    }

    def parsed_durations
      return unless respond_to?(:durations)

      @parsed_durations ||= durations.split(",").map(&:to_f).sort
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
