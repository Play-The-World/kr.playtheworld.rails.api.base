Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :tests, only: [:index, :create, :show, :destroy]
    # namespace :list do
    #   get '', action: :index
    #   post :join
    #   get :show
    # end
    resources :topics do
      member do
        get :super_themes
      end
    end
    resources :super_themes
  end
end
