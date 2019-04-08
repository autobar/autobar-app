class Order < ApplicationRecord
    has_and_belongs_to_many :drinks, optional: true
    belongs_to :user, optional: true
    
    def completed?
        completed
    end
end
