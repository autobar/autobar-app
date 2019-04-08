class Drink < ApplicationRecord
  #serialize :ingredients
  
  has_many :ingredients
  has_and_belongs_to_many :orders, optional: true
  belongs_to :user, optional: true
  has_one_attached :image
  
  validates :name,  presence: true, length: { maximum: 100 }
  validates :tag,  presence: true, length: { maximum: 50 }
  
  def self.alphabetical
    all.order(name: :asc) 
  end
end
