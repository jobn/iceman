#frozen_string_literal: true

Rails.application.routes.draw do
  scope "/api" do
    resources :users, only: %w[index show]
    resources :plans do
      resources :events, shallow: true
    end
    post "/sessions", to: "sessions#create"
    delete "/sessions", to: "sessions#destroy"
  end
end
