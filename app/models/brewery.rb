class Brewery < ApplicationRecord
    include BasicCounting
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    #validates :name, uniqueness: true,
     #                length: { minimum: 1 }
              
    validates :year, numericality: { greater_than_or_equal_to: 1047,
                                    less_than_or_equal_to: Proc.new { Time.now.year },
                                    only_integer: true } 
    validates :name, presence: true


end
