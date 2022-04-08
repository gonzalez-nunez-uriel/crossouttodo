Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get 'register', to: 'register#register'
  get 'register/success', to: 'register#success'
  post 'register', to: 'register#insert'
end
