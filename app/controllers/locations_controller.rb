class LocationsController < ApplicationController
  def index
    @locations = Unirest.get("http://localhost:3000/locations").body
  end

  def show
    @location = Unirest.get("http://localhost:3000/locations/#{params[:id]}").body
  end

  def new

  end

  def create
    @location = Unirest.post "http://localhost:3000/locations", 
                    headers:{ "Accept" => "application/json" }, 
                    parameters:{ street_address: params[:street_address],
                                 city: params[:city],
                                 state: params[:state],
                                 zipcode: params[:zipcode],
                                 country: params[:country]
                    }

    redirect_to "/locations"
  end
end
