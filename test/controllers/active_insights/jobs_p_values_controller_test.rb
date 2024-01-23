# frozen_string_literal: true

require "test_helper"

class ActiveInsights::JobsPValuesControllerTest <
  ActionDispatch::IntegrationTest
  test "#index" do
    Time.use_zone("Eastern Time (US & Canada)") do
      get active_insights.jobs_p_values_path(Date.current)

      assert_response :success
    end
  end

  test "#redirection" do
    get active_insights.jobs_p_values_redirection_path,
        params: { date: Date.new(2025, 1, 4) }

    assert_redirected_to active_insights.jobs_p_values_path(Date.new(2025,
                                                                     1, 4))
  end

  test "#index with job" do
    Time.use_zone("Eastern Time (US & Canada)") do
      get active_insights.job_p_values_path(Date.current, "DummyJob")

      assert_response :success
    end
  end

  test "#redirection with controller" do
    get active_insights.job_p_values_redirection_path("DummyJob"), params: {
      date: Date.new(2025, 1, 4)
    }

    assert_redirected_to active_insights.job_p_values_path(
      Date.new(2025, 1, 4), "DummyJob"
    )
  end
end
