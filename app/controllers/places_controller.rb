class PlacesController < ApplicationController
 # before_action :set_place, only:[:show, :update]

  def index
  end

  def show
    #@places = BeermappingApi.places_in(session[:last_city])
    @chosen_place = BeermappingApi.places_in(session[:last_city]).find{ |p| p.id== params[:id]}        
    
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_city] = params[:city]
      render :index
    end
  end

  #def set_place
   # @place = Place.find(params[:id])
  #end

end

