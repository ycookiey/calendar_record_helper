Rails.application.routes.draw do
  root 'calendar_helper#new'
  post 'calendar_helper/create'
  get 'calendar_helper/new'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  post 'auth/:provider', to: 'omniauth#redirect', as: :auth_redirect
  get 'auth/:provider', to: 'omniauth#redirect'
end