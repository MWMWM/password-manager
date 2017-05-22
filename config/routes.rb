Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :password_entries, only: [:create, :show, :update, :destroy]
    end
  end
end
