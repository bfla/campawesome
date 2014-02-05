class CreateVibes < ActiveRecord::Migration
  def change
    create_table :vibes do |t|
      t.integer :campsite_id
      t.integer :tribe_id

      t.timestamps
    end
  end
end
