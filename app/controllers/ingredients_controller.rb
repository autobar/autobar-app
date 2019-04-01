class IngredientsController < ApplicationController
    def new
        @ingredient = Ingredient.new
    end
    
    def create
        @ingredient = Ingredient.new(ingredient_params)
    
        if @ingredient.save
          # handle the creation of a new drink
          flash[:success] = "#{@ingredient.name} successfully created"
          redirect_to @ingredient
        else
          # handle a failed ingredient creation
          render 'ingredients/new'
        end
    end
    
    def index
        @ingredients = Ingredient.alphabetical.where({drink: nil})
    end
    
    def show
        @ingredient = Ingredient.find(params[:id])
    end
    
    def edit
        @ingredient = Ingredient.find(params[:id])
    end
    
    def update
        @ingredient = Ingredient.find(params[:id])
        @ingredient.update_attributes!(ingredient_params)
        flash[:success] = "Ingredient #{@ingredient.name} successfully updated"
        redirect_to @ingredient
    end

    def destroy
        @ingredient = Ingredient.find(params[:id])
        @ingredient.destroy!
        flash[:success] = "Ingredient #{@ingredient.name} successfully deleted"
        redirect_to ingredients_path
    end

    private # ---------- PRIVATE ----------

    # whitelist all of the parameters passed in forms to create
    # or edit an Ingredient
    def ingredient_params
        params.require(:ingredient).permit(:name, :amount, :liquor, :mixer, :pump)
    end
end