class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.integer :campsite_id
      t.float :value
      t.string :per
      t.string :unit
      t.text :description
      t.text :comment

      t.timestamps
    end
  end
end
