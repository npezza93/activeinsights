# frozen_string_literal: true

require "test_helper"

class ActiveInsights::BasicAuthenticationTest < ActionDispatch::IntegrationTest
  test "it does not require http basic auth by default" do
    get active_insights.requests_path

    assert_response :success
  end

  test "it requires http basic auth when enabled" do
    with_http_basic_auth do
      get active_insights.requests_path

      assert_response :unauthorized
    end
  end

  test "allows access with correct credentials" do
    with_http_basic_auth(user: "dev", password: "secret") do
      get active_insights.requests_path, headers: auth_headers("dev", "secret")

      assert_response :success
    end
  end

  test "disallows access with incorrect credentials" do
    with_http_basic_auth(user: "dev", password: "secret") do
      get active_insights.requests_path, headers: auth_headers("dev", "wrong")

      assert_response :unauthorized
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def with_http_basic_auth(enabled: true, user: nil, password: nil)
    previous_enabled, ActiveInsights.http_basic_auth_enabled =
      ActiveInsights.http_basic_auth_enabled, enabled
    previous_user, ActiveInsights.http_basic_auth_user =
      ActiveInsights.http_basic_auth_user, user
    previous_password, ActiveInsights.http_basic_auth_password =
      ActiveInsights.http_basic_auth_password, password
    yield
  ensure
    ActiveInsights.http_basic_auth_enabled = previous_enabled
    ActiveInsights.http_basic_auth_user = previous_user
    ActiveInsights.http_basic_auth_password = previous_password
  end
  # rubocop:enable Metrics/MethodLength

  def auth_headers(user, password)
    {
      Authorization:
        ActionController::HttpAuthentication::Basic.encode_credentials(
          user, password
        )
    }
  end
end
