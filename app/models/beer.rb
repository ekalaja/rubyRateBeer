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
end
