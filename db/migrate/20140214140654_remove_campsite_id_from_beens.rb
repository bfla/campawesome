class RemoveCampsiteIdFromBeens < ActiveRecord::Migration
  def change
    remove_column :beens, :campsite_id, :integer
  end
end
