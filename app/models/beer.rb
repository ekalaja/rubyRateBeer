class Beer < ApplicationRecord
 include BasicCounting
 
 belongs_to :brewery
 belongs_to :style
 has_many :ratings, dependent: :destroy
 has_many :raters, -> { uniq }, through: :ratings, source: :user


 validates :name, length: { minimum: 1 }
 validates :style, presence: true

    def to_s
        "#{name} #{brewery.name}"
    end

    def average
        return 0 if ratings.empty?
        ratings.map { |r| r.score }.sum / ratings.count.to_f
    end

    def self.top(n)
        sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
        sorted_by_rating_in_desc_order = sorted_by_rating_in_desc_order[0..n-1]
    end
    
end
