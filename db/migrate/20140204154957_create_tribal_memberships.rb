class CreateTribalMemberships < ActiveRecord::Migration
  def change
    create_table :tribal_memberships do |t|
      t.integer :tribe_id
      t.integer :user_id

      t.timestamps
    end
  end
end
