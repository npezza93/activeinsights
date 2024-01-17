# frozen_string_literal: true

require "importmap-rails"
require "chartkick"

require "active_insights/version"
require "active_insights/engine"

module ActiveInsights
  mattr_accessor :connects_to
end
