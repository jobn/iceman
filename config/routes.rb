#frozen_string_literal: true

Rails.application.routes.draw do
  scope "/api" do
    resources :users, only: %w[index]
    resources :plans do
      resources :events, shallow: true
    end
    get '/current_user', to: "users#current", as: :current_user
    post "/sessions", to: "sessions#create"
    delete "/sessions", to: "sessions#destroy"
  end
end
