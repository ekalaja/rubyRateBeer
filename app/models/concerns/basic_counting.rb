module BasicCounting
    extend ActiveSupport::Concern
    
    def average_rating
        return 0 if ratings.empty?
        ratings.map { |r| r.score }.sum / ratings.count.to_f
    end

    #def average_for_style(style)
        #ratings.select { |r| r.style = style}
        #return 0
    #end
  
end