# frozen_string_literal: true

require "activemetrics"

ActiveMetrics::Engine.configuration.importmap.draw do
  # pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
  pin "application", to: "active_metrics/application.js"

  pin "@hotwired/stimulus", to: "stimulus.js"
  pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
  pin_all_from ActiveMetrics::Engine.root.join("app/assets/javascripts/active_metrics/controllers"), to: "active_metrics/controllers", under: "controllers"

  pin "date_time_picker", to: "active_metrics/date_time_picker.js"
end
