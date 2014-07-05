class RenameTribeVibeColumn < ActiveRecord::Migration
  def change
    rename_column :tribes, :vibe, :adjective
  end
end
