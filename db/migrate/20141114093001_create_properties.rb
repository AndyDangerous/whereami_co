class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.multi_polygon :the_geom, srid: 26913
      t.string :name
      t.string :owner
      t.string :manager
      t.string :mgmt_code
      t.string :mgmt_description
      t.string :public_access

      t.timestamps
    end
  end
end
