Rails.application.routes.draw do
  root 'calendar_helper#new'
  post 'calendar_helper/create'
  get 'calendar_helper/new'
end