# frozen_string_literal: true

module ActiveInsights
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    around_action :setup_time_zone
    before_action :set_date

    private

    def set_date
      @date = requested_date..([requested_date.end_of_day, Time.current].min)
    end

    def setup_time_zone(&block) # rubocop:disable Style/ArgumentsForwarding
      Time.use_zone("Eastern Time (US & Canada)", &block) # rubocop:disable Style/ArgumentsForwarding
    end

    def requested_date
      if params[:date].present?
        Date.parse(params[:date])
      else
        Date.current
      end.beginning_of_day
    end

    def base_request_scope
      scope = ActiveInsights::Request.where(started_at: @date)
      if ActiveInsights.ignored_endpoints.present?
        scope = scope.where.
                not(formatted_controller: ActiveInsights.ignored_endpoints)
      end
      scope
    end

    def base_jobs_scope
      ActiveInsights::Job.where(started_at: @date)
    end
  end
end
