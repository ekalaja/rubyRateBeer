class Brewery < ApplicationRecord
    include BasicCounting
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

end
