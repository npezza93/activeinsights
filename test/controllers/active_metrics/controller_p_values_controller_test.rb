# frozen_string_literal: true

require "test_helper"

class ActiveMetrics::ControllerPValuesControllerTest <
  ActionDispatch::IntegrationTest

  test "#index" do
    Time.use_zone("Eastern Time (US & Canada)") do
      get active_metrics.controller_p_values_path(
        Date.current, "ActiveMetrics::ControllerPValuesController#index"
      )

      assert_response :success
    end
  end

  test "#redirection" do
    get active_metrics.controller_p_values_redirection_path(
      "ActiveMetrics::ControllerPValuesController#index"
    ), params: { date: Date.new(2025, 1, 4) }

    assert_redirected_to active_metrics.controller_p_values_path(
      Date.new(2025, 1, 4), "ActiveMetrics::ControllerPValuesController#index"
    )
  end
end
