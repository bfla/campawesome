class AddHashtagToState < ActiveRecord::Migration
  def change
    add_column :states, :hashtag, :string
  end
end
