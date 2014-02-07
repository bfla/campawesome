class FixStateAndCityColumnNames < ActiveRecord::Migration
  def change
    rename_column :states, :map_latitude, :latitude
    rename_column :states, :map_longitude, :longitude
    rename_column :cities, :desciption, :description
  end
end
