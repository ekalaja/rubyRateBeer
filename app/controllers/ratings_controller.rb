class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @bestBreweries = Brewery.top 3
    @bestBeers = Beer.top 3
    @bestStyles = Style.top 3
    @mostActiveRaters = User.top 3
    @recentRatings = Rating.recent
  end
  def new
    @rating = Rating.new
    @beers = Beer.all
  end
  
  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    if current_user
      @rating.user_id = current_user.id
    end
    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end



  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

end
