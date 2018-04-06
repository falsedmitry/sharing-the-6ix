class NeighbourhoodsController < ApplicationController
  def index
    @neighbourhoods = Neighbourhood.all
  end

  def show

  end
end
