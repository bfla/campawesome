class AddCityRankToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :city_rank, :integer
  end
end
