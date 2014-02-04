class TribalMembership < ActiveRecord::Base
  has_one :tribe
  has_one :user
  validates :tribe, :user, presence: true
end
