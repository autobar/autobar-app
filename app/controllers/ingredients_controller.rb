class IngredientsController < ApplicationController
    def new
        @ingredient = Ingredient.new
    end
    
    def create
    end
end
