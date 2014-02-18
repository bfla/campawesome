class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :campsite_id
      t.integer :tag_id
      t.integer :user_id

      t.timestamps
    end
  end
end
