class CreateWants < ActiveRecord::Migration
  def change
    create_table :wants do |t|
      t.integer :campsite_id
      t.integer :user_id

      t.timestamps
    end
  end
end
