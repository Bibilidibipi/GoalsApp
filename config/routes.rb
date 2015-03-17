Rails.application.routes.draw do
  root to: 'sessions#new'

  resources :users, only: [:new, :create, :show] do
    resources :goals, only: [:new, :create]
    resources :comments, only: [:new, :create]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:new, :create] do
    resources :comments, only: [:new, :create]
  end
  resources :comments, except: [:new, :create]
end
