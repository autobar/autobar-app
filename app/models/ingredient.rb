class Ingredient < ApplicationRecord
  belongs_to :drink, optional: true
end
