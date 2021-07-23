Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/api/v1/merchants/find", 'merchants#find'
  get "/api/v1/merchants/find_all", 'merchants#find_all'

  get '/api/v1/items/find', 'items#find'
  get '/api/v1/items/find_all', 'items#find_all'

  # get "/api/v1/merchants/most_items", to: 'merchants#most_items'

  namespace :api do
    namespace :v1 do
      
      get "merchants/most_items", to: 'merchants#most_items'
      resources :merchants, only: [:index, :show]
      get '/merchants/:id/items', to: 'merchants#items'


      resources :items, only: [:index, :show, :create, :update]
      get '/items/:id/merchant', to: 'items#merchant'

      get "revenue/merchants/:id", to: 'revenues#merchant'
      get "revenue/merchants", to: 'revenues#most_profitable'

    end
  end

end
