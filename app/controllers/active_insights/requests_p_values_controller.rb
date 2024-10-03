# frozen_string_literal: true

module ActiveInsights
  class RequestsPValuesController < ApplicationController
    def index
      @p50 = minutes.map{ |minute| [minute.pretty_started_at, minute.p50] }
      @p95 = minutes.map{ |minute| [minute.pretty_started_at, minute.p95] }
      @p99 = minutes.map{ |minute| [minute.pretty_started_at, minute.p99] }

      fetch_rpm
    end

    def redirection
      if formatted_controller.present?
        redirect_to controller_p_values_path(params[:date],
                                             formatted_controller)
      else
        redirect_to requests_p_values_path(params[:date])
      end
    end

    private

    def minutes
      @minutes ||= begin
        scope = base_request_scope.minute_by_minute.with_durations
        scope = scope.where(formatted_controller:) if
          formatted_controller.present?
        scope.select_started_at
      end
    end

    def formatted_controller
      params[:formatted_controller].presence
    end

    def fetch_rpm
      return if formatted_controller.blank?

      @rpm =
        minutes.select("COUNT(id) AS rpm").map do |minute|
          [minute.started_at.strftime("%-l:%M%P"), minute.rpm]
        end
    end
  end
end
