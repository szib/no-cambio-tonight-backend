# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/signin', to: 'users#signin' # username, password => token
      get '/validate', to: 'users#validate' # token => user || error

      resources :users, only: %i[create show]

      get '/profile', to: 'users#profile'
      patch '/profile', to: 'users#patch_profile'
      delete '/profile', to: 'users#destroy'
      get '/organisedEvents', to: 'users#organised_events' 
      get '/attendedEvents', to: 'users#attended_events' 

      resources :gamepieces, only: %i[create destroy index], path: 'mygames'
      get '/games/search', to: 'games#search'
      post '/games/save', to: 'games#save' # probably not needed at all

      resources :events, only: %i[show index create update] do
        # attendance
        get '/attendees', to: 'attendees#index'
        post '/rsvp', to: 'attendees#create'
        delete '/rsvp', to: 'attendees#destroy'
        
        # games
        get '/games', to: 'eventgames#index'
        post '/addgame', to: 'eventgames#create'
        delete '/removegame', to: 'eventgames#destroy'
      end
      # cancel
      get '/events/:id/cancel', to: 'events#cancel'
    end
  end
end
