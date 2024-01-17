# frozen_string_literal: true

require "active_insights"

ActiveInsights::Engine.importmap.draw do
  pin "application", to: "active_insights/application.js"

  pin "chartkick", to: "chartkick.js"
  pin "Chart.bundle", to: "Chart.bundle.js"

  pin "chartjs-plugin-zoom", to: "https://ga.jspm.io/npm:chartjs-plugin-zoom@2.0.1/dist/chartjs-plugin-zoom.esm.js"
  pin "hammerjs", to: "https://ga.jspm.io/npm:hammerjs@2.0.8/hammer.js"
  pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js"
  pin "chart.js/helpers", to: "https://ga.jspm.io/npm:chart.js@4.4.1/helpers/helpers.js"
end
