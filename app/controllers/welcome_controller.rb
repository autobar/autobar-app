class WelcomeController < ApplicationController
  def index
  end
  
  def pickdrink
    @drinks = Drink.alphabetical
  end
  
  def login
    if params[:creds] and params[:creds][:drivers_license]
      session[:dl] = params[:creds][:drivers_license]
    else
      session[:dl] = ''
      redirect_to welcome_path
      return
    end
    user = User.find_by(drivers_license: session[:dl])
    if user.nil?
      user = User.create(drivers_license: session[:dl])
    end
    redirect_to welcome_menu_path
  end
  
  def menu
    
  end
  
  def orders
    user = User.find_by(drivers_license: session[:dl])
    @drinks = Drink.where(user: user)
  end
end
