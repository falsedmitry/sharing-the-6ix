class NeighbourhoodsController < ApplicationController
  def index
    @neighbourhoods = Neighbourhood.all
  end

  def show
    @neighbourhood = Neighbourhood.find(params[:id])
    @users_in_neighbourhood = @neighbourhood.users
    @all_users = User.all

    @coords = []
    @all_users.each do |user|
      postal_code = JSON.parse(HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{user.location.split.join('+')},Toronto&bounds=43.855458,-79.002481|43.458297,-79.639219&key=AIzaSyA4smff7b389AgWQAZkI1CqrR2nB7cs0xM").body)["results"][0]["geometry"]["location"]

      lat = postal_code["lat"]
      lng = postal_code["lng"]

      @coords << [lat, lng]
    end

    @tools = @neighbourhood.tools

    case @neighbourhood.name # Just to translate some locations to GoogleMaps API language:
    when "The Junction"
      code = "The+Junction,Toronto"
    when "The Beaches"
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
    when "The Danforth"
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

    # error
  end
end
