Rails.application.routes.draw do

  resources :posts, only: [:create, :destroy, :edit, :show, :update]
  resources :comments
  
  get 'newsfeed/index'
  get '/confessions' => 'newsfeed#confessions'
  get '/users' => 'newsfeed#users'
  get '/ajax' => 'newsfeed#ajax'

  get 'notifications/show'
  get 'newsfeed/friendrequests'
  get '/profile/show'

  get '/:id', :to => "profile#show"
  root to: 'newsfeed#index'
  
  post 'likes/toggle_like'
  post 'dislikes/toggle_dislike'
  post '/users_api/sign_in'
  post 'users_api/sign_up'
  post 'friendrequests/toggle_follow_request'
  post 'newsfeed/un_follow'
  post 'newsfeed/delete_request'
  post 'friendrequests/accept_request'
  post 'friendrequests/reject_request'
  
  devise_for :users

end
