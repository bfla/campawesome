class AddReservableAndWalkinToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :reservable, :boolean
    add_column :campsites, :walkin, :boolean
  end
end
