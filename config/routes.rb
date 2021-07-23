Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/api/v1/merchants/find", 'merchants#find'
  get "/api/v1/merchants/find_all", 'merchants#find_all'

  get '/api/v1/items/find', 'items#find'
  get '/api/v1/items/find_all', 'items#find_all'


  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      get '/merchants/:id/items', to: 'merchants#items'

      get "/revenue/merchants", to: 'merchants#most_items'

      resources :items, only: [:index, :show, :create, :update]
      get '/items/:id/merchant', to: 'items#merchant'

      # get 'revenue/merchants', to: 'merchants#'
      # get "/merchants/find", 'merchants#find'
      # get "/merchants/find_all", 'merchants#find_all'
      #
      # get '/items/find', 'items#find'
      # get '/items/find_all', 'items#find_all'

    end
  end

end
