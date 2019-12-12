Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resource :tests, only: [:index, :create, :show, :destroy]
    # namespace :list do
    #   get '', action: :index
    #   post :join
    #   get :show
    # end
  end
end
