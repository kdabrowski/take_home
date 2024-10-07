# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/users/create', to: 'users#create'
      post '/auth/login', to: 'auth#login'

      post '/events/create', to: 'events#create'
      post '/events/book', to: 'events#book'
      get '/events/organised', to: 'events#organised'
      get '/events/participating', to: 'events#participating'
      get '/events/participants', to: 'events#participants'
    end
  end
end
