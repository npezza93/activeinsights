import {Chart, registerables} from "chart.js"

Chart.register(...registerables)

import "chartjs-adapter-date-fns"
import zoomPlugin from 'chartjs-plugin-zoom'
import Chartkick from "chartkick"

window.Chartkick = Chartkick
window.Chart = Chart

Chartkick.use(Chart)
Chart.register(zoomPlugin)
