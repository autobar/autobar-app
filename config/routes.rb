Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/menu'
  get 'welcome/pickdrink'
  post 'welcome/login'
  post 'drink/remove_image', to: 'drinks#remove_image'
  
  resources :drinks
  resources :orders
end