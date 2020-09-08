Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :v1, defaults: { format: :json } do
    namespace :test do
      get :job
      get :pusher
    end

    namespace :pusher do
      post :auth
    end

    # 제작 툴 사이트용 API
    namespace :making do
      namespace :test do
        get '/theme_list', action: :index_theme
        get '/themes', action: :show_theme
        post '/themes', action: :create_theme
        patch '/themes', action: :update_theme
        delete '/themes', action: :destroy_theme
        post '/images', action: :upload_images
        get '/images/:id', action: :image
      end
      namespace :main do
        post :create_theme
      end
      namespace :sessions do
        get :current_user, action: :current_user_data
        get :email
        post :confirm_email
        post :sign_in
        post :sign_up
        delete :sign_out
        patch :nickname, action: :update_nickname
        patch :password, action: :update_password
        patch :email, action: :update_email
        get :test
      end
      resources :super_themes, only: [:index, :show, :create, :update, :destroy] do
      end
      resources :themes, only: [:index, :show, :update, :destroy] do

      end
      resources :edit, only: [] do
        member do
          post :stage_list
          delete :image, action: :remove_image
          post :image, action: :create_image
          patch :image, action: :update_image
        end
      end
    end

    # 플레이 사이트용 API
    namespace :playing do
      namespace :test do
        post :new_play
        post :next_stage_list
      end
      namespace :main do
        get :news
        get :banners
        get :topics
        get :create_new_play
      end
      namespace :sessions do
        get :email
        post :confirm_email
        post :sign_in
        post :sign_up
        delete :sign_out
        patch :update_nickname
        patch :update_password
        patch :update_email
        get :test
      end
      resources :themes, only: [:show] do
        member do
          post :play
          get :related_topics
        end
      end
      namespace :plays do
        post :set
        get :detail
        get :stage_lists
        post :answer
        post :hint
      end
      resources :super_themes, only: [:index, :show] do
      end
    end
  end

  resources :achievements do
  end
  resources :answers do
  end
  resources :boards do
    member do
      get :posts
    end
  end
  resources :branches do
  end
  resources :categories do
  end
  resources :chat_messages do
  end
  resources :chat_rooms do
  end
  resources :comments do
  end
  resources :conditions do
  end
  resources :events do
  end
  resources :expressions do
  end
  resources :genres do
  end
  resources :hints do
  end
  resources :inventories do
  end
  resources :items do
  end
  resources :locations do
  end
  resources :maker_teams do
  end
  resources :makers do
  end
  resources :plays do
  end
  resources :posts do
  end
  resources :rank_seasons do
  end
  resources :ranks do
  end
  resources :reviews do
  end
  resources :settings do
  end
  resources :stage_list_types do
  end
  resources :stage_lists do
  end
  resources :stages do
  end
  resources :super_plays do
  end
  resources :super_themes do
  end
  resources :teams do
  end
  resources :themes do
  end
  resources :tokens do
  end
  resources :topics do
    member do
      get :super_themes
    end
  end
  resources :variables do
  end
  resources :view_types do
  end

  # CORS Preflight
  match '*all' => 'application#cors_preflight', via: [:options]
end
