# frozen_string_literal: true

require "test_helper"

class ActiveInsights::JobsLatenciesControllerTest <
  ActionDispatch::IntegrationTest

  test "#index" do
    Time.use_zone("Eastern Time (US & Canada)") do
      get active_insights.jobs_latency_path(Date.current)

      assert_response :success
    end
  end

  test "#redirection" do
    get active_insights.jobs_latency_redirection_path,
        params: { date: Date.new(2025, 1, 4) }

    assert_redirected_to active_insights.jobs_latency_path(Date.new(2025, 1, 4))
  end
end
