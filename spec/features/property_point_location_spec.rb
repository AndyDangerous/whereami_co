require 'rails_helper'
RSpec.describe 'a polygon' do
  # define a (cartesian?) factory
  co_factory = RGeo::Cartesian.factory(:srid => 26913)
  # define a big polygon

  # Read and parse fixtures file
  file = File.read('spec/fixtures/co_fixtures.geojson') 
  json_fixture_properties = JSON.parse(file)
  property_one = Property.new(json_fixture_properties['features'][0]['properties'])

  # Parse geometry
  geometries = RGeo::GeoJSON.decode(file, json_parser: :json, geo_factory: co_factory)
  property_one = co_factory.polygon(geometries[0].geometry)
  # define a point in the polygon

  # define a point outside the polygon
  # the   point in the pg should be in the pg
  it 'oughtta have point inside the polygon' do
    expect(proprty_one.the_geom.contains?(point_one))
  end
  # the point outside the pg should be outside the pg
end
