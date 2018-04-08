class NeighbourhoodsController < ApplicationController
  def index
    @neighbourhoods = Neighbourhood.all
  end

  def show
    @neighbourhood = Neighbourhood.find(params[:id])
    @users = @neighbourhood.users

    @locations = []
    @users.each do |user|
      @locations << user.location
    end

    @tools = @neighbourhood.tools

    case @neighbourhood.name
    when "Junction"
      code = "The+Junction,Toronto"
    when "Beaches"
      code = "The+Beach,Toronto"
    when "Dundas West"
      code = "Little+Portugal,Toronto"
    when "Little Italy"
      code = "Little+Italy"
    when "Kensington Market"
      code = "Kensington+Market"
    when "Yonge & Eglinton"
      code = "Midtown+Toronto"
    when "East York"
      code = "East+York"
    when "Danforth"
      code = "Greektown"
    when "Liberty Village"
      code = "Liberty+Village"
    when "North York"
      code = "North+York"
    else
      code = @neighbourhood.name
    end

    address = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{code},Toronto&bounds=43.855458,-79.002481|43.458297,-79.639219&key=AIzaSyA4smff7b389AgWQAZkI1CqrR2nB7cs0xM")

    address_body = JSON.parse(address.body)
    puts address_body["resuts"]

    location = address_body["results"][0]["geometry"]["location"]
    bounds = address_body["results"][0]["geometry"]["bounds"]

    northeast = bounds["northeast"]
    southwest = bounds["southwest"]

    @north = northeast["lat"]
    @east = northeast["lng"]
    @south = southwest["lat"]
    @west = southwest["lng"]

    @lat = location["lat"]
    @lng = location["lng"]


  end
end
