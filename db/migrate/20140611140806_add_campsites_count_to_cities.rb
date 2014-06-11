class AddCampsitesCountToCities < ActiveRecord::Migration
  def change
    add_column :cities, :campsites_count, :integer, :default => 0
  end
end
