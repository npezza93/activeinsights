# frozen_string_literal: true

module ActiveInsights
  class ControllerPValuesController < ApplicationController
    def index
      @p50 = minutes.map{ |minute| [minute.pretty_started_at, minute.p50] }
      @p95 = minutes.map{ |minute| [minute.pretty_started_at, minute.p95] }
      @p99 = minutes.map{ |minute| [minute.pretty_started_at, minute.p99] }
    end

    def redirection
      redirect_to controller_p_values_path(params[:date],
                                           params[:formatted_controller])
    end

    private

    def minutes
      @minutes ||=
        base_scope.where(formatted_controller: params[:formatted_controller]).
        minute_by_minute.with_durations.select_started_at
    end
  end
end
