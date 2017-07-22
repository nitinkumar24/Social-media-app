Rails.application.routes.draw do



  resources :posts, only: [:create, :destroy]
   resources :comments
  get 'home/index'
  get 'newsfeed/index'
  get '/users' => 'newsfeed#users'
  root to: 'newsfeed#index'
  get '/ajax' => 'newsfeed#ajax'
  post 'likes/toggle_like'
  post 'dislikes/toggle_dislike'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
