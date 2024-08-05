Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/destroy'
  root 'calendar_helper#new'
  post 'calendar_helper/create'
  get 'calendar_helper/new'
end