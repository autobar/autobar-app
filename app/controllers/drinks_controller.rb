class DrinksController < ApplicationController
  def new
    @drink = Drink.new
  end
  
  def create
    @drink = Drink.new(drink_params)
    @user = User.find_by(drivers_license: session[:dl])
    if not @user.is_admin
      @drink.user = @user
    end
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
    @user = User.find_by(drivers_license: session[:dl])
    if not @user.is_admin
      @drinks = Drink.where({user: @user}).alphabetical + (Drink.where({user: nil}).alphabetical)
    else
      @drinks = Drink.where({user: nil}).alphabetical
    end
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
    @user = User.find_by(drivers_license: session[:dl])
    @drink = Drink.find(params[:id])
    if @user.is_admin or @drink.user
      @drink.update_attributes!(drink_params)
      flash[:success] = "Drink #{@drink.name} successfully updated"
      redirect_to @drink
    else
      drink = @drink.dup
      drink.user = @user
      drink.image.attach(@drink.image.blob)
      drink.save
      @drink.ingredients.each do |ingredient|
        local_ingredient = ingredient.dup
        local_ingredient.drink = drink
        local_ingredient.save
      end
      drink.update_attributes!(drink_params)
    end
  end
  
  def destroy
    @user = User.find_by(drivers_license: session[:dl])
    @drink = Drink.find(params[:id])
    if @drink.user == @user or @user.is_admin
      @drink.ingredients.each do |ingredient|
        ingredient.destroy
      end
      @drink.destroy!
      flash[:success] = "Drink #{@drink.name} successfully deleted"
    else
      flash[:success] = "Drink #{@drink.name} is not yours to delete."
    end
    redirect_to drinks_path
  end
  
  def remove_image
    @user = User.find_by(drivers_license: session[:dl])
    @drink = Drink.find(params[:id])
    if @drink.user == @user
      @drink.image.purge
      flash[:success] = "Successfully removed image from #{@drink.name}"
    else
      flash[:success] = "Drink #{@drink.name} is not yours to edit."
    end
    redirect_to edit_drink_path(@drink)
  end
  
  def pick_drink
    @drinks = Drink.alphabetical
  end
  
  def toggle_ingredient
    @user = User.find_by(drivers_license: session[:dl])
    @drink = Drink.find(params[:id])
    if @drink.user != @user
      drink = @drink.dup
      drink.user = @user
      drink.image.attach(@drink.image.blob)
      drink.save
      @drink.ingredients.each do |ingredient|
        local_ingredient = ingredient.dup
        local_ingredient.drink = drink
        local_ingredient.save
      end
      @drink = drink
    end
    @ingredient = @drink.ingredients.find_by(id: params[:i_id])
    if @ingredient
      @ingredient.destroy
    else
      ingredient = Ingredient.find(params[:i_id])
      @ingredient = ingredient.dup
      @ingredient.drink = @drink
      @ingredient.save
    end
    redirect_to edit_drink_path(@drink)
  end
  
private # ---------- PRIVATE ----------

  # whitelist all of the parameters passed in forms to create
  # or edit a Drink
  def drink_params
    params.require(:drink).permit(:name, :ingredients, :default, :tag, :image)
  end
end
