# frozen_string_literal: true

module ActiveMetrics
  class RequestsController < ApplicationController
    def index
      @requests =
        ActiveMetrics::Request.where(started_at: @date).
        with_durations.select(:formatted_controller).
        group(:formatted_controller).
        sort_by { |model| model.durations.count(",") + 1 }.reverse
    end
  end
end
