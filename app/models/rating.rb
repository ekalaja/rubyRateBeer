class Rating < ApplicationRecord
    belongs_to :beer
    belongs_to :user

    validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }
                                    
    #scope :recent -> { all order(created_at: :desc).limit(5) }
    #scope :recent, ->(num) { order('created_at DESC').limit(num) }
    #scope :recent, lambda { |num| order('created_at DESC').limit(num) }
    scope :recent, -> { order(created_at: :desc).limit(5) }


    def to_s
        "#{beer.name} #{score} "
    end
    
end
