Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get 'uikit', to: 'pages#uikit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :colonies do
    resources :cats
    resources :events, only: %i[new create]
    resources :associations, only: %i[create]
  end

  resources :events, only: %i[show edit update destroy] do
    resources :participations, only: %i[create]
  end
  resources :cats, only: %i[index show new create edit update destroy]
  resources :users, only: %i[index show]
  resources :associations, only: %i[destroy]
  resources :participations, only: %i[destroy]
end
