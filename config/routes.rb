Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
      post '/login', to: 'users#login' # username, password => token
      post '/validate', to: 'users#validate' # token => user || error
    end
  end
end
