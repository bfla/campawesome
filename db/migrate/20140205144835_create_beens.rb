class CreateBeens < ActiveRecord::Migration
  def change
    create_table :beens do |t|
      t.integer :campsite_id
      t.integer :user_id

      t.timestamps
    end
  end
end
