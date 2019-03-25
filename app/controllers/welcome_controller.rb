class WelcomeController < ApplicationController
  def index
  end
  
  def pickdrink
    @drinks = Drink.alphabetical
  end
end
