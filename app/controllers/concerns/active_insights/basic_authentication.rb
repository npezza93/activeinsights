# frozen_string_literal: true

module ActiveInsights::BasicAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_by_http_basic
  end

  def authenticate_by_http_basic
    return unless http_basic_authentication_enabled?

    if http_basic_authentication_configured?
      http_basic_authenticate_or_request_with(**http_basic_auth_credentials)
    else
      head :unauthorized
    end
  end

  def http_basic_authentication_enabled?
    ActiveInsights.http_basic_auth_enabled
  end

  def http_basic_authentication_configured?
    http_basic_auth_credentials.values.all?(&:present?)
  end

  def http_basic_auth_credentials
    {
      name: ActiveInsights.http_basic_auth_user,
      password: ActiveInsights.http_basic_auth_password
    }.transform_values(&:presence)
  end
end
