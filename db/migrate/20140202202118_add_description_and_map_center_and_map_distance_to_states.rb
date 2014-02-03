class AddDescriptionAndMapCenterAndMapDistanceToStates < ActiveRecord::Migration
  def change
    add_column :states, :description, :text
    add_column :states, :map_latitude, :float
    add_column :states, :map_longitude, :float
    add_column :states, :map_distance, :float
  end
end
