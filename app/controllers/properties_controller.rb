class PropertiesController < ApplicationController
  def landing
  end

  def show
#    @property = Property.find(params[:id])
    @lat_lng = cookies[:lat_lng].split("|")
    # find property from lat lon - model?
    # return property info
  end
end
