Rails.application.routes.draw do
  mount ActiveInsights::Engine => "/insights"
  resources :make_requests, only: :index
end
