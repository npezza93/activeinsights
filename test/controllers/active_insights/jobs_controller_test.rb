# frozen_string_literal: true

require "test_helper"

class ActiveInsights::JobsControllerTest < ActionDispatch::IntegrationTest
  test "#index" do
    get active_insights.jobs_path

    assert_response :success
  end
end
