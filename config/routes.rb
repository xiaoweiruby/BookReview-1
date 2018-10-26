Rails.application.routes.draw do
  resources :books
  root 'books#index'
end
