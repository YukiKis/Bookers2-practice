Rails.application.routes.draw do
  get 'homes/about'
  root "homes#home"
  devise_for :users
  resources :users do
    member do
      get :followers
      get :following
    end
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
