# frozen_string_literal: true

module ActiveInsights
  class JobsPValuesController < ApplicationController
    def index
      @p50 = minutes.map{ |minute| [minute.pretty_started_at, minute.p50] }
      @p95 = minutes.map{ |minute| [minute.pretty_started_at, minute.p95] }
      @p99 = minutes.map{ |minute| [minute.pretty_started_at, minute.p99] }

      fetch_jpm
    end

    def redirection
      if job.present?
        redirect_to job_p_values_path(params[:date], job)
      else
        redirect_to jobs_p_values_path(params[:date])
      end
    end

    private

    def minutes
      @minutes ||= begin
        scope = base_jobs_scope.minute_by_minute.with_durations
        scope = scope.where(job:) if job.present?
        scope.select_started_at
      end
    end

    def job
      params[:job].presence
    end

    def fetch_jpm
      return if job.blank?

      @jpm =
        minutes.select("COUNT(id) AS jpm").map do |minute|
          [minute.started_at.strftime("%-l:%M%P"), minute.jpm]
        end
    end
  end
end
