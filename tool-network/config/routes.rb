Rails.application.routes.draw do
  root 'tools#index'

  resources :tools do
    resources :reviews do
      resources :images
    end
  end
  
  resources :users
end
