# frozen_string_literal: true

module ActiveMetrics
  module ApplicationHelper
    def active_metrics_importmap_tags(entry_point = "application")
      importmap = ActiveMetrics::Engine.configuration.importmap

      safe_join [
        javascript_inline_importmap_tag(importmap.to_json(resolver: self)),
        javascript_importmap_module_preload_tags(importmap),
        javascript_import_module_tag(entry_point)
      ], "\n"
    end

    def display_date(date)
      if Date.current.year == date.year
        date.strftime("%B %-d")
      else
        date.strftime("%B %-d, %Y")
      end
    end

    def p50(data)
      percentile_value(data, 0.5)
    end

    def p95(data)
      percentile_value(data, 0.95)
    end

    def p99(data)
      percentile_value(data, 0.99)
    end

    def per_minute(amount, duration)
      (amount / duration.in_minutes).round(0)
    end

    private

    def percentile_value(data, percentile)
      value = data[(percentile * data.size).ceil - 1]

      if value.respond_to?(:duration)
        value.duration
      else
        value
      end.round(1)
    end
  end
end
