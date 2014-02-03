class AddZoomToStates < ActiveRecord::Migration
  def change
    add_column :states, :zoom, :integer
  end
end
