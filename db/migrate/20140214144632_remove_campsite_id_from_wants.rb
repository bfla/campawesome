class RemoveCampsiteIdFromWants < ActiveRecord::Migration
  def change
    remove_column :wants, :campsite_id, :integer
  end
end
