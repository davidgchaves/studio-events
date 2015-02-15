Rails.application.routes.draw do
  root "events#index"

  resources :events do
    resources :registrations
  end

  get "signup" => "users#new"
  resources :users
end
