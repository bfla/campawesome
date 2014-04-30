class AddRvLengthToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :rv_length, :integer
  end
end
