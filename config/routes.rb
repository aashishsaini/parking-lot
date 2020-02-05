Rails.application.routes.draw do
  namespace :api do
    resources :tickets, only: [:index, :create, :show] do
      member do
        post :payments
        get :state
      end
    end
  end
  get 'api/free-spaces' => 'application#free_spaces'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
