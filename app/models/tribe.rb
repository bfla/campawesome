class Tribe < ActiveRecord::Base
  has_many :tribal_memberships
  has_many :users, through: :tribal_memberships
  validates :name, :description, :vibe, presence: true
end
