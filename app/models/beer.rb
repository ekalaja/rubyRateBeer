class Beer < ApplicationRecord
 include BasicCounting
 belongs_to :brewery
 has_many :ratings, dependent: :destroy

    #def average_rating
        #a = self.ratings
        #sum = 0
        #a.each do |i|
       #     sum = sum + i.score
      #  end
     #   return sum.to_f / self.ratings.count
    #end
    def to_s
        "#{name} #{brewery.name}"

    end
end
