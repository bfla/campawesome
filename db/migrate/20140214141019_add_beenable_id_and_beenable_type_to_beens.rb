class AddBeenableIdAndBeenableTypeToBeens < ActiveRecord::Migration
  def change
    add_column :beens, :beenable_id, :integer
    add_column :beens, :beenable_type, :string
  end
end
