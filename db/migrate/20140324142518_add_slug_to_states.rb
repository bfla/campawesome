class AddSlugToStates < ActiveRecord::Migration
  def change
    add_column :states, :slug, :string
    add_index :states, :slug, unique:true
  end
end
