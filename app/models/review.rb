class Review < ActiveRecord::Base
  validates :body, :user, presence:true
  belongs_to :user
  belongs_to :campsite, :destination, polymorphic:true 
end
