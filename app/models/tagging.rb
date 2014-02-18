class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :campsite
  belongs_to :user
  validates :tag, :campsite, :user, presence:true
end
