Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "wines#index"
  resources :wines, only: [:index]
  get '/wine_price_histories', :to => 'wines#wine_price_histories'
  get '/fetch_wines_via_external_api', :to => 'wines#fetch_wines_via_external_api'
  
  resources :reviews, only: [:index, :show, :create, :update, :destroy]

end

