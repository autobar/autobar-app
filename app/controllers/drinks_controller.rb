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
    default_ingredients = Ingredient.alphabetical.where({drink: nil})
    ingredients = Ingredient.alphabetical.where({drink: @drink})
    @ingredients = Hash.new()
    default_ingredients.each do |ingredient|
      found = false
      ingredient_of_drink = nil
      ingredients.each do |ingredient2|
        if ingredient2.name == ingredient.name
          ingredient_of_drink = ingredient2
          found = true
          break
        end
      end
      if found
        @ingredients[ingredient_of_drink] = true
      else
        @ingredients[ingredient] = false
      end
    end
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
  
  def toggle_ingredient
    puts params
  end
  
private # ---------- PRIVATE ----------

  # whitelist all of the parameters passed in forms to create
  # or edit a Drink
  def drink_params
    params.require(:drink).permit(:name, :ingredients, :default, :tag, :image)
  end
end
