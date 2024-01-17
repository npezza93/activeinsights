# frozen_string_literal: true

require "importmap-rails"
require "chartkick"

require "active_metrics/version"
require "active_metrics/engine"

module ActiveMetrics
  mattr_accessor :connects_to
end
