class Drink < ApplicationRecord
  serialize :ingredients
  
  validates :name,  presence: true, length: { maximum: 100 }
  validates :tag,  presence: true, length: { maximum: 50 }
  
  def self.alphabetical
    all.order(name: :asc) 
  end
end
