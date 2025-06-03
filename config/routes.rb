Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :projects, only: [:index, :show, :new, :create] do
    resources :photos, only: [:new, :create, :show]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end