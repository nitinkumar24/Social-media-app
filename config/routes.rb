Rails.application.routes.draw do





  resources :posts, only: [:create, :destroy, :edit, :show]
  resources :comments

  get 'home/index'
  get 'newsfeed/index'
  get '/users' => 'newsfeed#users'
  get '/ajax' => 'newsfeed#ajax'
  get 'newsfeed/profile'
  get 'notifications/show'
  root to: 'newsfeed#index'

  post 'likes/toggle_like'
  post 'dislikes/toggle_dislike'
  post '/users_api/sign_in'
  post 'users_api/sign_up'


  devise_for :users, :controllers => {:registrations => 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
