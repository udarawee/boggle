Rails.application.routes.draw do
  root 'pages#index'
  namespace :api do
    resource :games, only: [:create] do
      collection do
        post 'save'
      end
    end
  end
end
