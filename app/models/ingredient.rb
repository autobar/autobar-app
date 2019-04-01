class Ingredient < ApplicationRecord
  belongs_to :drink, optional: true
  def self.alphabetical
    all.order(name: :asc) 
  end
end
