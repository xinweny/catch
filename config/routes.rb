Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'uikit', to: 'pages#uikit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :colonies do
    resources :cats, only: %i[new create]
    resources :events, only: %i[new create]
  end

  resources :cats, only: %i[index show edit update destroy]
  resources :events, only: %i[show edit update destroy]
  resources :users, only: %i[index show]
end
