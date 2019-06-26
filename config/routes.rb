Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/login', to: 'users#login' # username, password => token
      post '/validate', to: 'users#validate' # token => user || error

      resources :users, only: [:create, :show]
      
      get '/profile', to: 'users#profile'
      patch '/profile', to: 'users#patch_profile'
      delete '/profile', to: 'users#destroy'
      get '/myevents', to: 'users#events'

      resources :gamepieces, only: [:create, :destroy, :index], path: 'mygames'
      get '/games/search', to: 'games#search'
      post '/games/save', to: 'games#save' # probably not needed at all

      resources :events, only: [:show, :index, :create] do
        resources :attendance, only: [:index, :create, :destroy]
        resources :eventgame, only: [:index, :create, :destroy], path: 'games'
      end
      get '/events/:id/cancel', to: 'events#cancel'

    end
  end
end
