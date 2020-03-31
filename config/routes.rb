Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :portraits do
  	resource :memories, only: [:create,:edit,:update,:destroy]
  	resource :bouquets, only: [:create,:destroy]
  end
  root 'portraits#index'
end
