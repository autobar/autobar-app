class OrdersController < ApplicationController
  require 'json'  
  def create_from_json
    user = User.find_by(drivers_license: session[:dl])
    puts "WE IN IT"
    puts user
    puts ""
    puts params
    puts params["order"]["list"]
    puts ""
    name = params["order"]["name"]
    phone_number = params["order"]["phone_number"]
    if name.empty? or phone_number.empty?
      puts "Missing fields"
      flash[:error] = "Missing fields"
      redirect_to root_path
      return
    end
    user.name = name
    user.phone_number = phone_number
    user.save
    list = JSON.parse(params["order"]["list"])
    if list.length > 0
      puts "New Order!"
      new_order = Order.create
      new_order.user = user
      list.each do |drink_id|
        puts "Listing drink order: " + drink_id.to_s
        new_order.drinks << Drink.find_by(id: drink_id)
      end
      new_order.save
    end
    
    redirect_to root_path
  end
  
  def show
    @order = Order.find(params[:id])
    @recipes = Array.new
    
    @order.drinks.each do |drink|
      @recipes << drink.ingredients
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end
  
  # this is not really an "index" per se, it will only show the 
  # first Order in the Order queue -dom
  # NOTE: this method will mark an Order as completed! if you do
  #       not want this to be done, use the above show method and
  #       specify the ID in your request
  def index
    twilio_client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = 'Come over, swipe your card, and pick up your order!'
    @order = Order.where(completed: false).first
    unless @order.nil?
      @order.update_attributes!(completed: true)
    end
    if @order.nil? or @order.drinks.nil?
      render json: ""
      return
    end
    @recipes = Array.new
    @recipes[0] = Hash.new
    @recipes[0][:drivers_license] = @order.user.drivers_license
    @recipes[0][:phone_number] = @order.user.phone_number
    @recipes[0][:name] = @order.user.name
    @order.drinks.each do |drink|
      recipe = Hash.new
      drink.ingredients.each do |ingredient|
        recipe[ingredient.name] = ingredient.amount
      end
      @recipes << recipe
    end
    render json: @recipes
    
    user = @order.user
    phone_number = ''
    if not user.phone_number.empty?
      if ! user.phone_number.include? "+1"
        phone_number = '+1'
      end
      phone_number << user.phone_number
      twilio_client.messages.create from: Rails.application.secrets.twilio_phone_number, to: phone_number, body: message
      puts "\e[32m(" + phone_number + ") Sent message: " + message + "\e[0m"
    end
  end
end
