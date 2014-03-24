class AddSlugToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :slug, :string
    add_index :campsites, :slug, unique:true
  end
end
