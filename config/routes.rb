Rails.application.routes.draw do
  
  resources :posts, only: [:create, :destroy, :edit, :show]
  resources :comments
  
  get 'newsfeed/index'
  get '/users' => 'newsfeed#users'
  get '/ajax' => 'newsfeed#ajax'
  get 'newsfeed/profile'
  get 'notifications/show'
  get 'newsfeed/friendrequests'
  root to: 'newsfeed#index'
  
  post 'likes/toggle_like'
  post 'dislikes/toggle_dislike'
  post '/users_api/sign_in'
  post 'users_api/sign_up'
  post 'newsfeed/follow'
  post 'newsfeed/un_follow'
  post 'newsfeed/delete_request'
  post 'newsfeed/accept_request'
  post 'newsfeed/reject_request'
  
  devise_for :users

end
