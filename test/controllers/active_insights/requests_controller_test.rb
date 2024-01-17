# frozen_string_literal: true

require "test_helper"

class ActiveInsights::RequestsControllerTest < ActionDispatch::IntegrationTest
  test "#index" do
    get active_insights.requests_path

    assert_response :success
  end
end
