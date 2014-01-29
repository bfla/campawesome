class AddLatitudeAndLongitudeAndAddressToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :latitude, :float
    add_column :campsites, :longitude, :float
    add_column :campsites, :address, :string
  end
end
