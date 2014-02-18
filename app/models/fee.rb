class Fee < ActiveRecord::Base
  belongs_to :campsite
  validates :campsite, presence:true
end
