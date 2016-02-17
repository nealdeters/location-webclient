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
    response = Unirest.post("http://localhost:3000/locations", 
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
    @location = Location.new(Unirest.get("http://localhost:3000/locations/#{params[:id]}").body)
  end

  def update
    @location = Unirest.patch("http://localhost:3000/locations/#{params[:id]}", 
                    headers:{ "Accept" => "application/json" }, 
                    parameters:{ street_address: params[:street_address],
                                 city: params[:city],
                                 state: params[:state],
                                 zipcode: params[:zipcode],
                                 country: params[:country]
                    }).body
    render :show
  end

  def destroy
    @location = Location.find(params[:id])
    message = @location.destroy

    redirect_to "/locations"
    flash[:message] = message["message"]
  end
end
