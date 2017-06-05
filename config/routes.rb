Rails.application.routes.draw do
  root to: 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :password_entries, only: [:index, :create, :show, :update, :destroy] do
        member do
          get :generate_sharing
        end
        resource :sharings, only: [] do
          member do
            get :use
          end
        end
      end
    end
  end
end
