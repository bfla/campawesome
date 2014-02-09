class List < ActiveRecord::Base
  belongs_to :user
  has_many :listeds, dependent: :destroy
  has_many :campsites, through: :listeds
end
