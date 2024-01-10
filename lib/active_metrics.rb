# frozen_string_literal: true

require "importmap-rails"

require "active_metrics/version"
require "active_metrics/engine"
require "active_metrics/railtie"

module ActiveMetrics
  mattr_accessor :connects_to
end
