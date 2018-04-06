class NeighbourhoodsController < ApplicationController
  def index
    @neighbourhoods = Neighbourhood.all
  end

  def show
    @neighbourhood = Neighbourhood.find(params[:id])

    @tools = @neighbourhood.tools

  end
end
