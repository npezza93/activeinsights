# frozen_string_literal: true

ActiveMetrics::Engine.routes.draw do
  resources :requests, only: %i(index)
  get "/requests/:date", to: "requests#index"
  get "/requests/rpm/redirection", to: "rpm#redirection", as: :rpm_redirection
  get "/requests/:date/rpm", to: "rpm#index", as: :rpm

  get "/requests/p_values/redirection", to: "p_values#redirection", as: :p_values_redirection
  get "/requests/:date/p_values", to: "p_values#index", as: :p_values

  root "requests#index"
end
