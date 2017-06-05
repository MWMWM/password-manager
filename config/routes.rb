Rails.application.routes.draw do
  root to: 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :password_entries, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
