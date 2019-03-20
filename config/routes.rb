Rails.application.routes.draw do
  root 'welcome#index'
  
  get 'welcome/pickdrink'
  
  resources :drinks
end