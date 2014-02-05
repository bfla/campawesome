class TribalMembership < ActiveRecord::Base
  belongs_to :tribe
  belongs_to :user
  validates :tribe, :user, presence: true
end
