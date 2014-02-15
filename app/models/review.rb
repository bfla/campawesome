class Review < ActiveRecord::Base
  validates :user, presence:true
  belongs_to :user
  has_one :rating, dependent: :destroy
  belongs_to :reviewable, polymorphic:true
  before_save :store_avg_rating

end
