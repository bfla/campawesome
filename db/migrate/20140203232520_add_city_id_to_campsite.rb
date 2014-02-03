class AddCityIdToCampsite < ActiveRecord::Migration
  def change
    add_column :campsites, :city_id, :integer
  end
end
