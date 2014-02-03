class RemoveMapDistanceFromState < ActiveRecord::Migration
  def change
    remove_column :states, :map_distance, :float
  end
end
