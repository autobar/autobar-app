class WelcomeController < ApplicationController
  def index
  end
  
  def pickdrink
    @drinks = Drink.alphabetical
  end
  
  def login
    redirect_to welcome_menu_path
  end
  
  def menu
    
  end
end
