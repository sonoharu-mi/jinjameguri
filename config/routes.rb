Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {sessions: 'admin/sessions'}
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :posts, only: [:destroy]
    resources :post_comments, only: [:destroy]
  end

  root to: "homes#top"
  devise_for :users
  get "/homes/about" => "homes#about", as: "about"
  get '/mypage' => "users#mypage", as: "mypage"
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:mypage, :show, :edit, :update, :destroy]
  get "/search" => "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
