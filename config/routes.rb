Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get 'register', to: 'register#register'
  get 'register/success', to: 'register#success'
  post 'register', to: 'register#insert'
  get 'error/bad-registration/validation-error', to: 'error#registration_validation_error'
  get 'error/bad-registration/password-mismatch', to: 'error#registration_password_mismatch'
  post '/login', to: 'login#authenticate'
  get 'dashboard', to: 'dashboard#dashboard'
end
