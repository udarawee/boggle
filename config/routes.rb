Rails.application.routes.draw do
  root 'pages#index'
  namespace :api do
    resource :games, only: :create
  end
end
