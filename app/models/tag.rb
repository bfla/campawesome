class Tag < ActiveRecord::Base
  has_many :taggings
  validates :name, :type, presence:true
end
