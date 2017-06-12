#frozen_string_literal: true

Rails.application.routes.draw do
  scope "/api" do
    resources :users, only: %w[index]
    get '/current_user', to: "users#current", as: :current_user
    post "/sessions", to: "sessions#create"
    delete "/sessions", to: "sessions#destroy"
  end
end
