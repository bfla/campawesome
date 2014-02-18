class Tag < ActiveRecord::Base
  has_many :taggings
  validates :name, :category, presence:true
end
