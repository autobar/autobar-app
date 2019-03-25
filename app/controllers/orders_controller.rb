class OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json {
        @recipes = Array.new
        @order.drinks.each do |drink|
          @recipes << drink.ingredients
        end
        render json: @recipes
      }
    end
  end
  
  # this is not really an "index" per se, it will only show the 
  # first Order in the Order queue -dom
  # NOTE: this method will mark an Order as completed! if you do
  #       not want this to be done, use the above show method and
  #       specify the ID in your request
  def index
    @order = Order.where(completed: false).first
    unless @order.nil?
      @order.update_attributes!(completed: true)
    end
    
    respond_to do |format|
      format.html
      format.json {
        @recipes = Array.new
        
        render json: @recipes and return if @order.nil?
        
        @order.drinks.each do |drink|
          @recipes << drink.ingredients
        end
        render json: @recipes
      }
    end
  end
end
