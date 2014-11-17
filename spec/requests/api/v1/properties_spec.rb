require 'rails_helper'

describe "Properties API" do
  it 'sends a boolean public vs. private response' do
    #Create a geometry
    # each property needs 
    #   properties - parse fixture as JSON and extract from hash
    #   geom - parse fixture as RGeo::GeoJSON, build in factory
    co_factory = RGeo::Cartesian.factory(:srid => 26913, geometry_type: :multi_polygon)
    file = File.read('spec/fixtures/co_fixtures.geojson') 
    
    json_fixture_properties = JSON.parse(file)
    property_one = Property.new(json_fixture_properties['features'][0]['properties'])

    geometries = RGeo::GeoJSON.decode(file, json_parser: :json, geo_factory: co_factory, geometry_type: :multi_polygon)
    co_factory.polygon(geometries[0].geometry)

    2.times do |i|
      property = Property.new(json_fixture_properties['features'][i]['properties'])
      property.the_geom = geometries[i].geometry
      property.save
    end

    binding.pry
#    geometries.each do |geometry|
#      Property.new(geometry)
#    end
    
    # test coordinates in west half of state
    # test coordinates in east half of state
    # test coordinates outside state
    get '/api/v1/properties' # plus lat/lon, etc

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json['public?']).to eq(true)
  end
end
