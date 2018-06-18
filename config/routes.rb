Rails.application.routes.draw do





    get 'user_block/blockkarnahai'

    resources :replies
    get 'mentions', to: 'search#mentions'


    get 'search/users'

    get 'search/autocomplete'

    resources :posts, only: [:create, :destroy, :edit, :show, :update]
    resources :comments

    get 'newsfeed/index'
    get '/confessions' => 'newsfeed#confessions'
    get '/memes' => 'newsfeed#memes'

    get '/users' => 'newsfeed#users'
    get '/ajax' => 'newsfeed#ajax'
    get 'mode/select'
    get 'notifications/show'
    get 'notifications/view'
    get '/requests' => 'friendrequests#requests'
    get '/profile/show'
    get 'profile/edit_picture'
    get 'profile/followers'
    get 'profile/following'



    get '/:id', :to => "profile#show"
    root to: 'newsfeed#index'

    post 'likes/toggle_like'
    post 'dislikes/toggle_dislike'
    post '/users_api/sign_in'
    post 'users_api/sign_up'
    post 'friendrequests/toggle_follow_request'
    post 'mode/set_mode'
    post 'mode/add_open_mode'
    post 'newsfeed/un_follow'
    post 'newsfeed/delete_request'
    post 'friendrequests/accept_request'
    post 'friendrequests/reject_request'
    post 'friendrequests/remove_follower'



    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}

    namespace :api do
        namespace :v1 do
            devise_scope :user do
                post '/sign_in' => 'sessions#create'
                get '/newsfeed' => 'newsfeed#home'
                post '/sign_up' => 'registrations#create'
                post 'forgot_password' => 'passwords#create'
                post 'resend_confirmations' => 'confirmations#create'
                get 'mode_list' => 'mode#mode_list'
                get 'notifications' => 'notifications#show'
            end


        end
    end
end
