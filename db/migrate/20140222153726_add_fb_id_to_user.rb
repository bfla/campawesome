class AddFbIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :fb_id, :integer
  end
end
