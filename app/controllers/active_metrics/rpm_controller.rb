# frozen_string_literal: true

module ActiveMetrics
  class RpmController < ApplicationController
    def index
      @minutes =
        ActiveMetrics::Request.where(started_at: @date).
        group_by_minute.select("COUNT(id) AS rpm").select_started_at.
        map { |minute| [minute.started_at.strftime("%-l:%M%P"), minute.rpm] }
    end

    def redirection
      redirect_to rpm_path(params[:date])
    end
  end
end
