class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :ratable_id
      t.string :ratable_type
      t.float :value
      t.integer :user_id

      t.timestamps
    end
  end
end
