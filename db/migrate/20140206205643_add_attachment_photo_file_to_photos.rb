class AddAttachmentPhotoFileToPhotos < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.attachment :photo_file
    end
  end

  def self.down
    drop_attached_file :photos, :photo_file
  end
end
