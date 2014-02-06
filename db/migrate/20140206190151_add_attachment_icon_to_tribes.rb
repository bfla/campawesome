class AddAttachmentIconToTribes < ActiveRecord::Migration
  def self.up
    change_table :tribes do |t|
      t.attachment :icon
    end
  end

  def self.down
    drop_attached_file :tribes, :icon
  end
end
