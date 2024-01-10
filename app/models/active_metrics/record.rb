# frozen_string_literal: true

module ActiveMetrics
  class Record < ApplicationRecord
    self.abstract_class = true

    connects_to(**ActiveMetrics.connects_to) if ActiveMetrics.connects_to
  end
end
