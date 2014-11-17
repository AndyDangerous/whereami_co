require 'rails_helper'

describe "Properties API" do
  it 'sends a boolean public vs. private response' do
    #Create a geometry
    file = File.open('spec/fixtures/co_fixtures.geojson') 
    binding.pry
    geometries = RGeo::GeoJSON.decode(file, json_parser: :json)
    geometries.each do |geometry|
      Property.new(geometry)
    end
    
    # test coordinates in west half of state
    # test coordinates in east half of state
    # test coordinates outside state
    get '/api/v1/properties' # plus lat/lon, etc

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json['public?']).to eq(true)
  end
end
