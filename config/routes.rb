Rails.application.routes.draw do



  resources :posts, only: [:create, :destroy, :edit]
  resources :comments
  get 'home/index'
  get 'newsfeed/index'
  get '/users' => 'newsfeed#users'
  root to: 'newsfeed#index'
  get '/ajax' => 'newsfeed#ajax'
  get 'newsfeed/profile'

  post 'likes/toggle_like'
  post 'dislikes/toggle_dislike'
  post '/users_api/sign_in'
  post 'users_api/sign_up'


  devise_for :users, :controllers => {:registrations => 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
