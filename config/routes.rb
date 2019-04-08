Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/menu'
  get 'welcome/pickdrink'
  get 'welcome/orders'
  post 'welcome/login'
  get 'welcome/logout'
  
  post 'drink/remove_image', to: 'drinks#remove_image'
  get 'drinks/toggle_ingredient'
  
  resources :drinks
  resources :orders
  resources :ingredients
end