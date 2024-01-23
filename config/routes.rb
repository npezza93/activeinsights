# frozen_string_literal: true

ActiveInsights::Engine.routes.draw do
  resources :requests, only: %i(index)
  resources :jobs, only: %i(index)
  get "/jobs/:date", to: "jobs#index"
  get "/requests/:date", to: "requests#index"

  get "/requests/rpm/redirection", to: "rpm#redirection", as: :rpm_redirection
  get "/requests/:date/rpm", to: "rpm#index", as: :rpm

  get "/requests/p_values/redirection", to: "requests_p_values#redirection",
                                        as: :requests_p_values_redirection
  get "/requests/:date/p_values", to: "requests_p_values#index", as: :requests_p_values
  get "/requests/:date/:formatted_controller/p_values",
      to: "requests_p_values#index", as: :controller_p_values
  get "/requests/:formatted_controller/p_values/redirection",
      to: "requests_p_values#redirection",
      as: :controller_p_values_redirection

  get "/jobs/jpm/redirection", to: "jpm#redirection", as: :jpm_redirection
  get "/jobs/:date/jpm", to: "jpm#index", as: :jpm

  root "requests#index"
end
