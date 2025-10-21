Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations], controllers: {sessions: 'admin/sessions'}
  root to: "homes#top"
  devise_for :users
  get "/homes/about" => "homes#about", as: "about"
  get '/mypage' => "users#mypage", as: "mypage"
  resources :users, only: [:mypage, :show, :edit, :update, :destroy]
  resources :posts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
