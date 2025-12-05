Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {sessions: 'admin/sessions'}
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :destroy]
    resources :posts, only: [:index, :destroy]
    resources :post_comments, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
  end

  root to: "homes#top"
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  get "/homes/about" => "homes#about", as: "about"
  get '/mypage' => "users#mypage", as: "mypage"
  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  resources :tags, only: [:show]
  resources :users, only: [:mypage, :index, :show, :edit, :update, :destroy, :destroy]
  get "/search", to: "searches#search"
  resources :groups, only: [:create, :index, :show, :edit, :update, :destroy] do
    resources :group_users, only: [:create] do
      member do
        delete :leave
        patch :approve
        patch :reject
      end
    end
  end
  resources :calendars, only: [:index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
