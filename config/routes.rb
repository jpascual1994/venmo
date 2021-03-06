Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: %i[show create] do
        member do
          get :balance
          get :feed
        end

        scope module: :users do
          resources :payments, only: :create
        end
      end
    end
  end
end
