# frozen_string_literal: true

module ActiveInsights
  class PValuesController < ApplicationController
    def index
      @p50 = minutes.map{ |minute| [minute.pretty_started_at, minute.p50] }
      @p95 = minutes.map{ |minute| [minute.pretty_started_at, minute.p95] }
      @p99 = minutes.map{ |minute| [minute.pretty_started_at, minute.p99] }
    end

    def redirection
      redirect_to p_values_path(params[:date])
    end

    private

    def minutes
      @minutes ||=
        ActiveInsights::Request.where(started_at: @date).
        group_by_minute.with_durations.select_started_at
    end
  end
end
