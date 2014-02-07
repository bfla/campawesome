class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :campsite
  belongs_to :destination
  belongs_to :city
  belongs_to :state
  has_attached_file :photo_file,
                    :styles => { :large => "400x400>", :small => "100x100>", :small => "50x50>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo_file, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :photo_file, less_than:5.megabytes
end
