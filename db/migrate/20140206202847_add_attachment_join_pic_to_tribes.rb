class AddAttachmentJoinPicToTribes < ActiveRecord::Migration
  def self.up
    change_table :tribes do |t|
      t.attachment :join_pic
    end
  end

  def self.down
    drop_attached_file :tribes, :join_pic
  end
end
