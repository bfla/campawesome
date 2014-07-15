class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :anchor
      t.string :href
      t.text :title
      t.integer :city_id
      t.integer :destination_id
      t.integer :state_id

      t.timestamps
    end
  end
end
