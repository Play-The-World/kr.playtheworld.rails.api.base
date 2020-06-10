Rails.application.routes.draw do
  apipie
  namespace :v1, defaults: { format: :json } do
    # 제작 툴 사이트용 API
    namespace :making do
      namespace :main do
      end
    end
    # 플레이 사이트용 API
    namespace :playing do
      namespace :main do
        get :topics
      end
      namespace :sessions do
        get :email
        post :confirm_email
        post :sign_in
        post :sign_up
        delete :sign_out
        patch :update_nickname
      end
    end
    resources :tests do
      collection do
        get :pong
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
    
  end
end
