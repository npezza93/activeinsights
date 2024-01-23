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

  get "/jobs/p_values/redirection", to: "jobs_p_values#redirection",
                                    as: :jobs_p_values_redirection
  get "/jobs/:date/p_values", to: "jobs_p_values#index", as: :jobs_p_values

  get "/jobs/:date/:job/p_values",
      to: "jobs_p_values#index", as: :job_p_values
  get "/jobs/:job/p_values/redirection",
      to: "jobs_p_values#redirection",
      as: :job_p_values_redirection

  root "requests#index"
end
