class WelcomeController < ApplicationController
  def index
    if session[:dl]
      redirect_to welcome_menu_path
    end
    @orders = Order.where(completed: false)
  end
  
  def pickdrink
    @drinks = Drink.alphabetical
  end
  
  def login
    if params[:creds] and params[:creds][:drivers_license] and not params[:creds][:drivers_license].empty?
      session[:dl] = params[:creds][:drivers_license]
    else
      redirect_to root_path
      return
    end
    user = User.find_by(drivers_license: session[:dl])
    if user.nil?
      user = User.create(drivers_license: session[:dl])
    end
    redirect_to welcome_menu_path
  end
  
  def logout
    session.delete(:dl)
    redirect_to root_path
  end
  
  def menu
    @orders = Order.where(completed: false)
  end
  
  def orders
    user = User.find_by(drivers_license: session[:dl])
    @orders = Order.where(user: user, completed: false)
  end
  
  def edit_user
    @user = User.find_by(drivers_license: session[:dl])
  end
  
  def update_user
    @user = User.find_by(drivers_license: session[:dl])
    @user.update_attributes!(user_params)
    redirect_to welcome_menu_path
  end
  
  private # ---------- PRIVATE ----------

  # whitelist all of the parameters passed in forms to create
  # or edit an Ingredient
  def user_params
      params.require(:user).permit(:name, :phone_number)
  end
end
