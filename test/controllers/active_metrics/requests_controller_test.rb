# frozen_string_literal: true

require "test_helper"

class ActiveMetrics::RequestsControllerTest < ActionDispatch::IntegrationTest
  test "#index" do
    get active_metrics.requests_path

    assert_response :success
  end
end
