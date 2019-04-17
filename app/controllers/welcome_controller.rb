class WelcomeController < ApplicationController
  def index
    if session[:dl]
      redirect_to welcome_menu_path
    end
    @orders = Order.where(completed: false).limit(5)
    @ordersComplete = Order.where(completed: true).reverse()[0]
  end
  
  def pickdrink
    @user = User.find_by(drivers_license: session[:dl])
    if not @user.is_admin
      @drinks = Drink.where({user: @user}).alphabetical + (Drink.where({user: nil}).alphabetical)
    else
      @drinks = Drink.where({user: nil}).alphabetical
    end
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
    @orders = Order.where(completed: false).limit(5)
    @ordersComplete = Order.where(completed: true).reverse()[0]
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
  
  def current_drink
    @ordersComplete = Order.where(completed: true).reverse()[0]
  end
  
  private # ---------- PRIVATE ----------

  # whitelist all of the parameters passed in forms to create
  # or edit an Ingredient
  def user_params
      params.require(:user).permit(:name, :phone_number)
  end
end
