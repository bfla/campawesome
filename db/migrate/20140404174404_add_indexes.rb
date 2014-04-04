class AddIndexes < ActiveRecord::Migration
  def change
    add_index :campsites, :avg_rating # so that campsites order themselves faster
    add_index :campsites, [:state_id, :avg_rating] # to get campsites for a state faster
    add_index :campsites, [:city_id, :avg_rating] # to get campsites for a city faster
    
    add_index :reviews, [:reviewable_id, :reviewable_type] # to get reviews for a campsite faster
    add_index :ratings, [:ratable_id, :ratable_type] # get ratings for a campsite faster
    add_index :photos, :campsite_id # to get a campsite's photos faster
    add_index :photos, :destination_id # to get a destination's photos faster

    # User's stuff should be indexed to the user for faster queries
    add_index :reviews, :user_id
    add_index :photos, :user_id
    add_index :lists, :user_id
    add_index :wants, :user_id
    add_index :beens, :user_id

    add_index :vibes, :campsite_id # get campsite's tribes faster
    add_index :taggings, :campsite_id # get a campsite's tags faster
    add_index :activities, :campsite_id # get a campsite's activities faster
    add_index :fees, :campsite_id # get a campsite's fees faster

    add_index :destinations, :state_id # get a state's destinations faster
  end
end
