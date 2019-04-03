class ApplicationController < ActionController::Base
  
  # POST /coffee_roasts
  def create
    @coffee_roast = Application.new(coffee_roast_params)
  
    respond_to do |format|
      if @coffee_roast.save
        message = "The coffee roast '#{@coffee_roast.roast_name}' was just added."
        TwilioTextMessenger.new(message).call
        format.html { redirect_to @coffee_roast, notice: 'Coffee roast was successfully created.' }
        format.json { render :show, status: :created, location: @coffee_roast }
      else
        format.html { render :new }
        format.json { render json: @coffee_roast.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def auth_check
    if not session[:dl] or session[:dl] == '' #No permission
      redirect_to welcome_menu_path
      return false
    else #Admin
      return true
    end
  end
  protect_from_forgery with: :exception
end


