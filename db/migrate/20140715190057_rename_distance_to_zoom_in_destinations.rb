class RenameDistanceToZoomInDestinations < ActiveRecord::Migration
  def change
    rename_column :destinations, :distance, :radius
  end
end
