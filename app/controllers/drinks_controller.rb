class DrinksController < ApplicationController
  
  def new
    @drink = Drink.new
  end
  
  def create
    @drink = Drink.new(drink_params)
    
    if @drink.save
      # handle the creation of a new drink
      flash[:success] = "Committee #{@drink.name} successfully created"
      redirect_to @drink
    else
      # handle a failed drink creation
      render 'drinks/new'
    end
  end

  def index
    @drinks = Drink.alphabetical
  end
  
  def show
    @drink = Drink.find(params[:id])
  end
  
  def edit
    @drink = Drink.find(params[:id])
  end
  
  def update
    @drink = Drink.find(params[:id])
    @drink.update_attributes!(drink_params)
    flash[:success] = "Drink #{@drink.name} successfully updated"
    redirect_to @drink
  end
  
  def destroy
    @drink = Drink.find(params[:id])
    @drink.destroy!
    flash[:success] = "Drink #{@drink.name} successfully deleted"
    redirect_to drinks_path
  end
  
  def remove_image
    @drink = Drink.find(params[:id])
    @drink.image.purge
    flash[:success] = "Successfully removed image from #{@drink.name}"
    redirect_to edit_drink_path(@drink)
  end
  
  def pick_drink
    @drinks = Drink.alphabetical
  end
  
  
private # ---------- PRIVATE ----------

  # whitelist all of the parameters passed in forms to create
  # or edit a Drink
  def drink_params
    params.require(:drink).permit(:name, :ingredients, :default, :tag, :image)
  end
end
