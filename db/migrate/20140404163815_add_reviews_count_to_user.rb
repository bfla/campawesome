class AddReviewsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :reviews_count, :integer, :default => 0
  end
end
