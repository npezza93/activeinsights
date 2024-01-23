# frozen_string_literal: true

module ActiveInsights
  class JobsController < ApplicationController
    def index
      @jobs = base_jobs_scope.with_durations.select(:job, :queue).
              group(:job, :queue).sort_by(&:agony).reverse
    end
  end
end
