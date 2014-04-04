class Photo < ActiveRecord::Base
  belongs_to :user, counter_cache: :photos_count
  belongs_to :campsite
  belongs_to :destination
  belongs_to :city
  belongs_to :state
  has_attached_file :photo_file,
                    :styles => { :large => "800x600>", :medium => "400x300>", :small => "200x150>", :thumbnail => "150x150#" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo_file, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :photo_file, less_than:5.megabytes
  validates :photo_file, :user_id, presence:true
end
