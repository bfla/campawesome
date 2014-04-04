class AddPhotosCountAndListsCountAndBeensCountAndWantsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :photos_count, :integer, default:0
    add_column :users, :lists_count, :integer, default:0
    add_column :users, :beens_count, :integer, default:0
    add_column :users, :wants_count, :integer, default:0
  end
end
