class AddDistanceToDestination < ActiveRecord::Migration
  def change
    add_column :destinations, :distance, :integer
  end
end
