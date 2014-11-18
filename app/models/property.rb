class Property < ActiveRecord::Base
  def find_property(lat_lng)
    lat = lat_lng[0]
    lng = lat_lng[1]

    pt_factory = RGeo::Cartesian.factory(:srid => 26913)
    user_location = pt_factory.point(lat, lng)
    
   parcel =  Property.all.select do |property| 
      property.wkb_geometry.contains?(user_location)
    end

   @property = parcel.first
  end
end
