class AddStateIdToCampsites < ActiveRecord::Migration
  def change
    add_column :campsites, :state_id, :integer
  end
end
