# frozen_string_literal: true

module ActiveInsights
  class JobsLatenciesController < ApplicationController
    def index
      @latencies = minutes.map do |minute|
        [minute.pretty_started_at, minute.latency.round(1)]
      end
    end

    def redirection
      redirect_to jobs_latency_path(params[:date])
    end

    private

    def minutes
      @minutes ||= base_jobs_scope.minute_by_minute.select_started_at.
                   select("AVG(queue_time) as latency")
    end
  end
end
