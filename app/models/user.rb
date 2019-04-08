class User < ApplicationRecord
    has_many :drinks
    has_many :orders
end
