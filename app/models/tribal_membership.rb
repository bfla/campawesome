class TribalMembership < ActiveRecord::Base
  belongs_to :tribe
  belongs_to :user
  validates :tribe_id, :user_id, presence: true
end
