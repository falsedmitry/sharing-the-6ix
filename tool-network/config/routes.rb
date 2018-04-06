Rails.application.routes.draw do
  root 'neighbourhoods#index'

  get 'login' => 'sessions#new', :as => :login
  delete 'logout' => 'sessions#destroy', :as => :logout
  post 'login' => 'sessions#create'


  resources :tools do
    resource :loan, only: %i(new show create)

    resources :reviews do
      resources :images
    end
  end

  resources :users
end
