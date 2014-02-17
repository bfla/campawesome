class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :activity_type_id
      t.integer :campsite_id
      t.integer :user_id
      t.text :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
