require 'rails_helper'

describe "Properties API" do
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
    
  it 'sends a boolean public vs. private response' do
    # test coordinates in west half of state
    # test coordinates in east half of state
    # test coordinates outside state
    binding.pry
    get '/api/v1/properties' # plus lat/lon, etc

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json['public?']).to eq(true)
  end
end
