Rails.application.routes.draw do
  root 'neighbourhoods#index'

  get 'login' => 'sessions#new', :as => :login
  delete 'logout' => 'sessions#destroy', :as => :logout
  post 'login' => 'sessions#create'

  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'
  get 'privacy' => 'pages#privacy'

  resources :tools do
    resource :loan, only: %i(new show create)
    resources :chats, only: %i(create)

    resources :reviews do
      resources :images
    end
  end

  resources :ratings, only: :update

  resources :users
  resources :neighbourhoods
  resources :chats, only: %i(index show edit update)
end
