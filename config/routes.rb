Rails.application.routes.draw do
  root to: "events#index"

  resources :events do
    resources :registrations, only: [:index, :new, :create]
  end

  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :new, :create]
end
