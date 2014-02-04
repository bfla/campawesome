class TribalMembership < ActiveRecord::Base
  belongs_to :tribe, dependent: :destroy
  belongs_to :user, dependent: :destroy
  validates :tribe, :user, presence: true
end
