class AddSlugToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :slug, :string
    add_index :destinations, :slug, unique:true
  end
end
