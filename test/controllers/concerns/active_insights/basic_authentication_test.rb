# frozen_string_literal: true

require "test_helper"

class ActiveInsights::BasicAuthenticationTest < ActionDispatch::IntegrationTest

  class TestController < ActionController::Base
    include ActiveInsights::BasicAuthentication

    def index
      render plain: "Hello from TestController"
    end
  end

  setup do
    @controller = TestController.new
    @original_routes = Rails.application.routes

    Rails.application.routes.draw do
      get "test", to: "active_insights/basic_authentication_test/test#index"
    end
  end

  teardown do
    Rails.application.routes_reloader.reload!
    ActiveInsights.http_basic_auth_enabled = nil
    ActiveInsights.http_basic_auth_user = nil
    ActiveInsights.http_basic_auth_password = nil
  end

  test "it does not require http basic auth by default" do
    get "/test"

    assert_response :success
  end

  test "it requires http basic auth when enabled" do
    ActiveInsights.http_basic_auth_enabled = true

    get "/test"

    assert_response :unauthorized
  end

  test "when enabled and proper credentials are included, it allows access" do
    ActiveInsights.http_basic_auth_enabled = true
    ActiveInsights.http_basic_auth_user = "johndoe"
    ActiveInsights.http_basic_auth_password = "secret"
    auth = ActionController::HttpAuthentication::Basic.encode_credentials(
      "johndoe", "secret"
    )

    get "/test", headers: { "HTTP_AUTHORIZATION" => auth }

    assert_response :success
  end
end
