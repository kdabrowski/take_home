Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/users/create', to: 'users#create'
      post '/auth/login', to: 'auth#login'
    end
  end
end
