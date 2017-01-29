module BasicCounting
    extend ActiveSupport::Concern
    def average_rating
        a = self.ratings
        sum = 0
        a.each do |i|
            sum = sum + i.score
        end
        return sum.to_f / self.ratings.count
    end
  
end