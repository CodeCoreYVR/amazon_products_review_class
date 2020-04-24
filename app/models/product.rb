class Product < ApplicationRecord
    validates :title, {
        presence: true, 
        uniqueness: { case_sensitive: false}
    }

    validates :price, {
        numericality: { greater_than_or_equal_to: 0}
    }
    
    validates :description, {
        presense: true, 
        length: { minimum: 10}
    }
end
