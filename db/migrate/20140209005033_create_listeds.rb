class CreateListeds < ActiveRecord::Migration
  def change
    create_table :listeds do |t|
      t.integer :campsite_id
      t.integer :list_id

      t.timestamps
    end
  end
end
