Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do

    # 제작 툴 사이트용 API
    namespace :making do
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
        member do
          delete :image, action: :remove_image
          post :image, action: :create_image
          patch :image, action: :update_image
        end
      end
    end

    # 플레이 사이트용 API
    namespace :playing do
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

  # CORS Preflight
  match '*all' => 'application#cors_preflight', via: [:options]
end
