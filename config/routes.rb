Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    # 제작 툴 사이트용 API
    namespace :making do
      namespace :main do
        post :create_theme
      end
      resources :super_themes, only: [:index, :show, :create, :update, :destroy] do
      end
    end
    resources :tests, only: [:index] do
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
end
