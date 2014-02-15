class AddAvgRatingToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :avg_rating, :float
  end
end
