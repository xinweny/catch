Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :colonies do
    resources :cats, only: %i[new create]
    resources :events, only: %i[index show new create]
  end

  resources :cats, only: %i[index show edit update destroy]
  resources :events, only: %i[edit update]
  resources :users, only: %i[index show]
end
