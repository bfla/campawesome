class Activity < ActiveRecord::Base
  belongs_to :activity_type
  belongs_to :campsite
  belongs_to :user
  validates :activity_type, :campsite, :user, presence:true

end
