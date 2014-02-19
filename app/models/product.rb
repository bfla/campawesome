class Product < ActiveRecord::Base
  has_attached_file :image,
                    :styles => { :large => "400x400>", :medium => "200x200>", :small => "100x100>" },
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :image, less_than:5.megabytes
  validates :name, :description, presence:true
end
