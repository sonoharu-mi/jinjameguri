Rails.application.routes.draw do
  get 'tags/index'
  get 'tags/show'
  devise_for :admin, skip: [:registrations, :password], controllers: {sessions: 'admin/sessions'}
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :posts, only: [:destroy]
    resources :post_comments, only: [:destroy]
    resources :groups, only: [:index, :destroy]
  end

  root to: "homes#top"
  devise_for :users
  get "/homes/about" => "homes#about", as: "about"
  get '/mypage' => "users#mypage", as: "mypage"
  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :tags, only: [:show]
  resources :users, only: [:mypage, :show, :edit, :update, :destroy, :destroy]
  get "/search", to: "searches#search"
  resources :groups, only: [:create, :index, :show, :edit, :update, :destroy] do
    resources :group_users, only: [:create, :destroy]
  end
  resources :group_users, only: [] do
    member do
      patch :approve
      patch :reject
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
