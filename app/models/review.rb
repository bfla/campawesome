class Review < ActiveRecord::Base
  validates :user, presence:true
  belongs_to :user
  has_one :rating
  belongs_to :reviewable, polymorphic:true
end
