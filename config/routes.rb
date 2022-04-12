Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get '/faq', to: 'home#faq'

  # registration
  get 'register', to: 'register#register'
  get 'register/success', to: 'register#success'
  post 'register', to: 'register#insert'
  # registration errors
  get 'error/bad-registration/validation-error', to: 'error#registration_validation_error'
  get 'error/bad-registration/password-mismatch', to: 'error#registration_password_mismatch'

  # login
  post '/login', to: 'login#authenticate'
  # login errors

  # dashboard
  get 'dashboard', to: 'dashboard#dashboard'
  get 'dashboard/new'
  post 'dashboard/new', to: 'dashboard#insert'
  get 'dashboard/task/:id', to: 'dashboard#details'
  post 'dashboard/delete'
  post 'dashboard/completed'
  get 'dashboard/history'
  post '/dashboard/not-completed'
  # dashboard errors
  get 'error/bad-task/validation-error', to: 'error#task_validation_error'
  get 'error/not-authorized', to: 'error#not_authorized'
end
