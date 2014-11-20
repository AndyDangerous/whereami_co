require 'rails_helper'

RSpec.describe Property, :type => :model do
  before(:each) do
    # Create factory with correct srid
    co_factory = RGeo::Cartesian.factory(:srid => 26913)

    # Read and parse fixtures file
    file = File.read('spec/fixtures/co_fixtures.geojson') 
    json_fixture_properties = JSON.parse(file)
    property_one = Property.new(json_fixture_properties['features'][0]['properties'])

    # Parse geometry
    geometries = RGeo::GeoJSON.decode(file, json_parser: :json, geo_factory: co_factory)
    co_factory.polygon(geometries[0].geometry)

    2.times do |i|
      property = Property.new(json_fixture_properties['features'][i]['properties'])
      property.the_geom = geometries[i].geometry
      property.save
    end
  end

  context 'points and polygons' do
    it 'can find the property containing a point' do
      # create point in one property
      # set var = property
      # find property as container for point
      western_us = Property.first
      eastern_us = Property.last

      wgs84_proj4 = '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
      co_factory = RGeo::Cartesian.factory(:srid => 26913)
      wgs84_factory = RGeo::Geographic.spherical_factory(proj4: wgs84_proj4, :srid => 4326)
      
      western_point_latlon = wgs84_factory.point(-106.2555986, 39.2680503)
      western_point = RGeo::Feature.cast(western_point_latlon, factory: co_factory, project: true)
      eastern_point = co_factory.point(-104.8163896, 39.033757)

binding.pry

      expect(western_us.the_geom.contains?(western_point)).to be_true
    end
  end

  xit { should validate_presence_of(:name) }
  
  # validate some things
  # find the property that contains a point
  # handle shitty input gracefully
  #   non point
  #   point outside colorado
end
