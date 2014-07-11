class AddEmailToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :email, :string
  end
end
