class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.integer :zoom
      t.integer :state_id
      
      t.timestamps
    end
  end
end
