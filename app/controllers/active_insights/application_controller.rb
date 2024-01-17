# frozen_string_literal: true

module ActiveInsights
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    around_action :setup_time_zone
    before_action :set_date

    private

    def set_date
      @date =
        if params[:date].present?
          Date.parse(params[:date])
        else
          Date.current
        end.all_day
    end

    def setup_time_zone(&block) # rubocop:disable Style/ArgumentsForwarding
      Time.use_zone("Eastern Time (US & Canada)", &block) # rubocop:disable Style/ArgumentsForwarding
    end
  end
end
