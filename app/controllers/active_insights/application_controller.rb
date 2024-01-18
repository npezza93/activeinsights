# frozen_string_literal: true

module ActiveInsights
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    around_action :setup_time_zone
    before_action :set_date

    private

    def set_date
      @date = if params[:date].present?
                starting = Date.parse(params[:date])
                starting..([starting.end_of_day, Time.current].min)
              else
                Date.current..([Date.current.end_of_day, Time.current].min)
              end
    end

    def setup_time_zone(&block) # rubocop:disable Style/ArgumentsForwarding
      Time.use_zone("Eastern Time (US & Canada)", &block) # rubocop:disable Style/ArgumentsForwarding
    end
  end
end
