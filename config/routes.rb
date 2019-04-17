Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/menu'
  get 'welcome/pickdrink'
  get 'welcome/orders'
  post 'welcome/login'
  get 'welcome/logout'
  get 'welcome/edit_user'
  post 'welcome/update_user'
  get 'welcome/current_drink'
  post 'drink/remove_image', to: 'drinks#remove_image'
  get 'drinks/toggle_ingredient'
  post 'orders/create_from_json'
  
  #Twilio
  get 'notifications/notify' => 'notifications#notify'
  
  resources :drinks
  resources :orders
  resources :ingredients
end