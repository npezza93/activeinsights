Rails.application.routes.draw do
  mount ActiveMetrics::Engine => "/metrics"
  resources :make_requests, only: :index
end
