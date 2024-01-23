# frozen_string_literal: true

module ActiveInsights
  class JobsController < ApplicationController
    def index
      @jobs = base_jobs_scope.with_durations.select(:job, :queue).
              group(:job, :queue).sort_by(&:agony).reverse

      @latency =
        base_jobs_scope.select("AVG(queue_time) as latency").first.latency
    end
  end
end
