Rails.application.routes.draw do
  get 'welcome/index'
 
  root 'welcome#index'
  
  get 'welcome/pickdrink'
end