class AddListableIdAndListableTypeToListeds < ActiveRecord::Migration
  def change
    add_column :listeds, :listable_id, :integer
    add_column :listeds, :listable_type, :string
  end
end
