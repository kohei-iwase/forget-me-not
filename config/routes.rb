Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit,:update,:index] do
    member do
      get :following, :followers
	end 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :portraits do
  	resources :memories, only: [:create,:edit,:update,:destroy,:show,:index] do
  		  resource :flowers,only: [:create,:destroy]
  		end
  	resource :bouquets, only: [:create,:destroy]
  end

  resources :relationships, only: [:create,:destroy]

  root 'portraits#index'
   # トップとアバウトページのrouting
   get 'homes/top' => 'homes#top'
   get 'homes/about' => 'homes#about'

end
