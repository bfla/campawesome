class AddWantableIdAndWantableTypeToWants < ActiveRecord::Migration
  def change
    add_column :wants, :wantable_id, :integer
    add_column :wants, :wantable_type, :string
  end
end
