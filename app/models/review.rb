class Review < ActiveRecord::Base
  validates :body, :user, presence:true
  belongs_to :user
  belongs_to :reviewable, polymorphic:true
end
