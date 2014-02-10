class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :user_id
      t.integer :reviewable_id
      t.string :reviewable_type

      t.timestamps
    end
  end
end
