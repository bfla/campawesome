class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :points
      t.integer :quantity

      t.timestamps
    end
  end
end
