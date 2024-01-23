# frozen_string_literal: true

module ActiveInsights
  class JpmController < ApplicationController
    def index
      @minutes =
        base_jobs_scope.minute_by_minute.select("COUNT(id) AS jpm").
        select_started_at.map do |minute|
          [minute.started_at.strftime("%-l:%M%P"), minute.jpm]
        end
    end

    def redirection
      redirect_to jpm_path(params[:date])
    end
  end
end
