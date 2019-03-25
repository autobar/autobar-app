class Order < ApplicationRecord
    has_many :drinks
    
    
    def completed?
        completed
    end
end
