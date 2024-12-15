# frozen_string_literal: true

require "importmap-rails"
require "chartkick"

require "active_insights/version"
require "active_insights/engine"

module ActiveInsights
  mattr_accessor :connects_to, :ignored_endpoints, :enabled,
                 :http_basic_auth_enabled, :http_basic_auth_user,
                 :http_basic_auth_password

  class << self
    def ignored_endpoint?(payload)
      ignored_endpoints.to_a.include?(
        "#{payload[:controller]}##{payload[:action]}"
      )
    end

    def enabled?
      if enabled.nil?
        !Rails.env.development?
      else
        enabled.present?
      end
    end
  end
end
