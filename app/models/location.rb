class Location
  attr_reader :id
  attr_accessor :street_address, :city, :state, :zipcode, :country

  def initialize(hash)
    @id = hash["id"]
    @street_address = hash["street_address"]
    @city = hash["city"]
    @state = hash["state"]
    @zipcode = hash["zipcode"]
    @country = hash["country"]
  end

  def full_address
    "#{street_address}, #{city}, #{state}, #{zipcode}"
  end

  def destroy
    Unirest.delete("http://localhost:3000/locations/#{id}", 
                    headers:{ "Accept" => "application/json" }).body
  end

  def self.find(id)
    Location.new(Unirest.get("http://localhost:3000/locations/#{id}").body)
  end

  def self.all
    # api_location_array = Unirest.get("http://localhost:3000/locations").body
    
    # locations = []

    # api_location_array.each do |api_location|
    #   locations << self.new(api_location)
    # end

    # locations

    Unirest.get("http://localhost:3000/locations").body.map { |api_location| Location.new(api_location) }
  end
end