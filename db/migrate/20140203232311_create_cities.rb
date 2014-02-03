class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.text :desciption
      t.float :latitude
      t.float :longitude
      t.integer :zoom
      t.integer :state_id

      t.timestamps
    end
  end
end
