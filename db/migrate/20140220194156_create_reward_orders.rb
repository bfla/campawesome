class CreateRewardOrders < ActiveRecord::Migration
  def change
    create_table :reward_orders do |t|
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end
end
