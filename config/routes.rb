# frozen_string_literal: true

ActiveMetrics::Engine.routes.draw do
  resources :requests, only: %i(index)

  root "requests#index"
end
