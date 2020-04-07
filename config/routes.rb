Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit,:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :portraits do
  	resource :memories, only: [:create,:edit,:update,:destroy,:show]
  	resource :bouquets, only: [:create,:destroy]
  end
  root 'portraits#index'
   # トップとアバウトページのrouting
   get 'homes/top' => 'homes#top'
   get 'homes/about' => 'homes#about'

end
