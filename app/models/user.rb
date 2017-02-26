class User < ApplicationRecord
    include BasicCounting
    
    has_secure_password
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings

    has_many :memberships, dependent: :destroy
    has_many :beer_clubs, through: :memberships



    validates :username, uniqueness: true,
                         length: { minimum: 3, maximum: 30 }
    validates :password, length: {minimum: 4},
                         format: { with: /[a-z].*/,
    message: "Password needs to contain lowercase letters" }

    validates :password, format: { with: /([A-Z].*\d)|(\d.*[A-Z].*)/,
              message: "should contain one number and one capital letter" }  
              
    def favorite_beer
        return nil if ratings.empty?
        ratings.sort_by{ |r| r.score }.last.beer
    end

    def favorite_style
        #fav_style = favorite_by(style)
        #return fav_style
        highest_a = 0
        fav_style = ''

        all_ratings_by_style = ratings.group_by{ |r| r.beer.style }
        all_ratings_by_style.each do | style_name, r_of_style|
            if highest_a < r_of_style.map(&:score).sum/r_of_style.count.to_f
               highest_a = r_of_style.map(&:score).sum/r_of_style.count.to_f
               fav_style = style_name
            end
        end
        fav_style
    end

    def favorite_brewery
        highest_a = 0
        fav_brewery = ''

        all_ratings_by_brewery = ratings.group_by{ |r| r.beer.brewery.name}
        all_ratings_by_brewery.each do | brewery_name, r_of_brewery|
            if highest_a < r_of_brewery.map(&:score).sum/r_of_brewery.count.to_f
               highest_a = r_of_brewery.map(&:score).sum/r_of_brewery.count.to_f
               fav_brewery = brewery_name
            end 
        end
        fav_brewery
    end

    def number_of_ratings
        self.ratings.count
    end

    def self.top(n)
        sorted_by_rating_in_desc_order = User.all.sort_by{ |u| -(u.ratings.count || 0) }
        sorted_by_rating_in_desc_order = sorted_by_rating_in_desc_order[0..n-1]
    end

end
