class AddSlugToCities < ActiveRecord::Migration
  def change
    add_column :cities, :slug, :string
    add_index :cities, :slug, unique:true
  end
end
