Rails.application.routes.draw do
  namespace :api do
    resources :tickets, only: [:index, :create, :show] do
      member do
        post :payments
        get :state
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
