class Link < ActiveRecord::Base
  belongs_to :destination
  belongs_to :city
  belongs_to :state

  validates :anchor, :href, presence:true
end
