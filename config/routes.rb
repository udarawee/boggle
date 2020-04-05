Rails.application.routes.draw do
  root 'pages#index'
  resource :games, only: :create
end
