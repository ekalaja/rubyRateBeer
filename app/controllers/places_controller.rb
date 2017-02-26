require 'beermapping_api'
class PlacesController < ApplicationController
 # before_action :set_place, only:[:show, :update]

  def index
  end

  def show
    #@places = BeermappingApi.places_in(session[:last_city])
    @place = BeermappingApi.places_in(session[:last_city]).find{ |p| p.id== params[:id]}        
    
  end

  def search
    city = params[:city]
    @places = BeermappingApi.places_in(city)
    @weather = WeatherService.weather_for(city)
    session['last_city'] = city

    render :index
  end


  #def set_place
   # @place = Place.find(params[:id])
  #end

end

