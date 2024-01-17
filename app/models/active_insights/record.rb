# frozen_string_literal: true

module ActiveInsights
  class Record < ApplicationRecord
    self.abstract_class = true

    connects_to(**ActiveInsights.connects_to) if ActiveInsights.connects_to
  end
end
