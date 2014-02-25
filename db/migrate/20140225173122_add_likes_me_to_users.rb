class AddLikesMeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :likes_me, :boolean
  end
end
