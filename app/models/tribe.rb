class Tribe < ActiveRecord::Base
  has_many :tribal_memberships, dependent: :destroy
  has_many :users, through: :tribal_memberships
  has_many :vibes, dependent: :destroy
  has_many :campsites, through: :vibes
  validates :name, :description, :vibe, presence: true
end
