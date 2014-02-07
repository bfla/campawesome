class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.string :license_type
      t.text :license_text
      t.integer :user_id
      t.integer :campsite_id
      t.integer :city_id
      t.integer :state_id
      t.integer :destination_id
      t.text :caption

      t.timestamps
    end
  end
end
