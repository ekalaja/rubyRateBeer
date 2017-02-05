class User < ApplicationRecord
    include BasicCounting
    
    has_secure_password
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings

    validates :username, uniqueness: true,
                         length: { minimum: 3, maximum: 30 }
    validates :password, length: {minimum: 4},
                         format: { with: /[a-z]/,
    message: "Password needs to contain lowercase letters" }

    validates :password, format: { with: /[A-Z]/,
    message: "Password needs to contain uppercase letters" }
                         

end
