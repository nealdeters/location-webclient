class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end

  def new

  end

  def create
    response = Unirest.post("https://polar-falls-44137.herokuapp.com/api/v1/locations.json", 
                    headers:{ "Accept" => "application/json" }, 
                    parameters:{ street_address: params[:street_address],
                                 city: params[:city],
                                 state: params[:state],
                                 zipcode: params[:zipcode],
                                 country: params[:country]
                    })

    if response.code == 200
      @location = response.body
      redirect_to "/locations"
    else
      @location = {}
      render :new
    end
  end

  def edit
    # @location = Location.new(Unirest.get("https://polar-falls-44137.herokuapp.com/locations/#{params[:id]}").body)
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update({ 
                     street_address: params[:street_address],
                     city: params[:city],
                     state: params[:state],
                     zipcode: params[:zipcode],
                     country: params[:country]
                    })
    # @location = Unirest.patch("https://polar-falls-44137.herokuapp.com/locations/#{params[:id]}", 
    #                 headers:{ "Accept" => "application/json" }, 
    #                 parameters:{ street_address: params[:street_address],
    #                              city: params[:city],
    #                              state: params[:state],
    #                              zipcode: params[:zipcode],
    #                              country: params[:country]
    #                 }).body
    render :show
  end

  def destroy
    @location = Location.find(params[:id])
    message = @location.destroy

    redirect_to "/locations"
    flash[:message] = message["message"]
  end
end
