class Review < ActiveRecord::Base

  belongs_to :user
  has_one :rating, dependent: :destroy
  belongs_to :reviewable, polymorphic:true

  validates :user, presence:true
  validates :title, length: {maximum:100}
  validates :body, presence:true, if: "rating.nil?"
  validates :rating, presence:true, if: "review.nil?"

end
