class RenameTypeInTags < ActiveRecord::Migration
  def up
    rename_column :tags, :type, :category
  end
  def down
    rename_column :tags, :category, :type
  end
end
