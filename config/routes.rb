Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
      post '/login', to: 'users#login' # username, password => token
      post '/validate', to: 'users#validate' # token => user || error

      resources :gamepieces, only: [:create, :destroy, :index], path: 'mygames'
      get '/games/search', to: 'games#search'
      post '/games/save', to: 'games#save' # probably not needed at all

      resources :events, only: [:show, :index, :create] do
        get '/cancel', to: 'events#cancel'
      end

    end
  end
end
