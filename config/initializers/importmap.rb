# frozen_string_literal: true

require "active_insights"

ActiveInsights::Engine.importmap.draw do
  pin "chartkick", to: "https://ga.jspm.io/npm:chartkick@5.0.1/dist/chartkick.esm.js"
  pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.4.1/dist/chart.js"
  pin "chartjs-adapter-date-fns", to: "https://ga.jspm.io/npm:chartjs-adapter-date-fns@3.0.0/dist/chartjs-adapter-date-fns.esm.js"
  pin "date-fns", to: "https://ga.jspm.io/npm:date-fns@3.2.0/index.mjs"

  pin "chartjs-plugin-zoom", to: "https://ga.jspm.io/npm:chartjs-plugin-zoom@2.0.1/dist/chartjs-plugin-zoom.esm.js"
  pin "hammerjs", to: "https://ga.jspm.io/npm:hammerjs@2.0.8/hammer.js"
  pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.2/dist/color.esm.js"
  pin "chart.js/helpers", to: "https://ga.jspm.io/npm:chart.js@4.4.1/helpers/helpers.js"
end
