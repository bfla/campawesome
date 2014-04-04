class AddIndexForAUsersTribalMembership < ActiveRecord::Migration
  def change
    add_index :tribal_memberships, :user_id
  end
end
