class RemoveCampsiteIdFromListeds < ActiveRecord::Migration
  def change
    remove_column :listeds, :campsite_id, :integer
  end
end
