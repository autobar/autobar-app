class ApplicationController < ActionController::Base
  before_action :check_logged_in
  
  def auth_check
    if not session[:dl] or session[:dl] == '' #No permission
      redirect_to welcome_menu_path
      return false
    else #Admin
      return true
    end
  end
  
  def check_logged_in
    if (controller_name != 'welcome' or action_name != 'index') and controller_name != 'orders'
        if not session[:dl] or session[:dl] == ''
          if action_name != 'login' and not User.find_by(drivers_license: session[:dl])
            redirect_to root_path
          end
        end
    end
    if session[:dl]
      @user = User.find_by(drivers_license: session[:dl])
    end
  end
  protect_from_forgery with: :exception
end


