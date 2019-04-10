class IngredientsController < ApplicationController
    def new
        @ingredient = Ingredient.new
    end
    
    def create
        @ingredient = Ingredient.new(ingredient_params)
        if params[:ingredient][:drink_type] == "mixer"
            @ingredient.liquor = false
            @ingredient.mixer = true
        else
            @ingredient.liquor = true
            @ingredient.mixer = false
        end
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
        @user = User.find_by(drivers_license: session[:dl])
        if not @user.is_admin
            redirect_to welcome_menu_path
        end
        @ingredients = Ingredient.alphabetical.where({drink: nil})
    end
    
    def show
        @ingredient = Ingredient.find(params[:id])
    end
    
    def edit
        @ingredient = Ingredient.find(params[:id])
    end
    
    def update
        @user = User.find_by(drivers_license: session[:dl])
        @ingredient = Ingredient.find(params[:id])
        if not @user.is_admin
            if @ingredient.drink.user != @user
                if @ingredient.drink_id != nil
                  drink = @ingredient.drink.dup
                  drink.user = @user
                  drink.default = false
                  drink.image.attach(@ingredient.drink.image.blob)
                  drink.save
                  @ingredient.drink.ingredients.each do |ingredient|
                    local_ingredient = ingredient.dup
                    local_ingredient.drink = drink
                    local_ingredient.save
                  end
                  flash[:success] = "Drink #{drink.name} has been made!"
                  redirect_to edit_drink_path(drink)
                  return
                end
                flash[:success] = "Ingredient #{@ingredient.name} is not yours to edit."
                redirect_to welcome_menu_path
                return
            end
        end
        if @ingredient.drink_id == nil
            if not auth_check
                flash[:success] = "Ingredient #{@ingredient.name} is not yours to edit."
                redirect_to welcome_menu_path
                return
            end
        end
        if params[:ingredient][:drink_type] == "mixer"
            @ingredient.liquor = false
            @ingredient.mixer = true
        else
            @ingredient.liquor = true
            @ingredient.mixer = false
        end
        @ingredient.update_attributes!(ingredient_params)
        flash[:success] = "Ingredient #{@ingredient.name} successfully updated"
        redirect_to @ingredient
    end

    def destroy
        @ingredient = Ingredient.find(params[:id])
        if @ingredient.drink_id == nil
            auth_check
        end
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