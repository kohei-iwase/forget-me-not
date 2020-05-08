Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update, :index] do
    member do
      get :following, :followers
      get :timelines
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :portraits do
    resources :memories, only: [:create, :edit, :update, :destroy, :show, :index] do
      resource :flowers, only: [:create, :destroy]
    end
    resources :anniversaries, only: [:create, :edit, :update, :destroy, :index]
    resource :bouquets, only: [:create, :destroy]
  end

  # フォロイー、フォロワー作成用
  resources :relationships, only: [:create, :destroy]
  # 通知用のルーティング
  resources :notifications, only: :index

  root 'homes#top'

  # トップとアバウトページのrouting
  get 'homes/top' => 'homes#top'
  get 'homes/about' => 'homes#about'

  # 検索用
  get 'search' => 'searches#search', as: 'search'
end
