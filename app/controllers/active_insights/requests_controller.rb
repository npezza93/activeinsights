# frozen_string_literal: true

module ActiveInsights
  class RequestsController < ApplicationController
    def index
      @requests =
        base_scope.with_durations.select(:formatted_controller).
        group(:formatted_controller).sort_by(&:agony).reverse
    end
  end
end
