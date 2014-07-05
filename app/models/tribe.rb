class Tribe < ActiveRecord::Base
  has_many :tribal_memberships, dependent: :destroy
  has_many :users, through: :tribal_memberships
  has_many :vibes, dependent: :destroy
  has_many :campsites, through: :vibes
  validates :name, :description, :adjective, presence: true
  has_attached_file :icon, 
                    :styles => { :large => "300x300>", :medium => "100x100>", :small => "50x50>" }, 
                    :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :icon, less_than:1.megabytes
  has_attached_file :join_pic,
                    :styles => {}, 
                    :default_url => "/images/:style/missing.png"
                    
  validates_attachment_size :icon, less_than:2.megabytes


end
