Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  get 'search', to: 'pages#search', as: :search
  get 'uikit', to: 'pages#uikit'
  get 'colonies/new/cats', to: 'colonies#search_cats', as: :search_cats

  resources :colonies do
    resources :cats
    resources :events, only: %i[new create]
    resources :associations, only: %i[create]
    resources :users, only: %i[index]
  end

  resources :events, only: %i[show edit update destroy] do
    resources :participations, only: %i[create]
  end

  get 'events/:id/updates', to: 'events#update_cats', as: :update_cats

  resources :cats, only: %i[index show new create edit update destroy]
  resources :users, only: %i[index show]
  resources :associations, only: %i[destroy]
  resources :participations, only: %i[destroy]
end
