# frozen_string_literal: true

require "test_helper"

puts ActiveInsights.http_basic_auth_enabled.inspect

class ActiveInsightsTest < ActiveSupport::TestCase
  teardown do
    ActiveInsights.http_basic_auth_enabled = nil
    ActiveInsights.http_basic_auth_user = nil
    ActiveInsights.http_basic_auth_password = nil
  end

  test "it has a version number" do
    assert ActiveInsights::VERSION
  end

  test "it does not enabled http basic auth by default" do
    assert_not ActiveInsights.http_basic_auth_enabled
  end

  test "it has an accessor to set whether http basic auth is enabled" do
    ActiveInsights.http_basic_auth_enabled = true

    assert ActiveInsights.http_basic_auth_enabled
  end

  test "it has an accessor to set http basic auth user" do
    ActiveInsights.http_basic_auth_user = "johndoe"

    assert_equal "johndoe", ActiveInsights.http_basic_auth_user
  end

  test "it has an accessor to set http basic auth password" do
    ActiveInsights.http_basic_auth_password = "secret"

    assert_equal "secret", ActiveInsights.http_basic_auth_password
  end
end
