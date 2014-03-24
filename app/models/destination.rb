class Destination < ActiveRecord::Base

  belongs_to :state
  has_many :photos
  validates :name, :description, :latitude, :longitude, :zoom, presence: true
  validates :latitude, numericality: {greater_than: 0}
  validates :longitude, numericality: {less_than: 0}
  validates :zoom, numericality: true
  has_many :reviews, as: :reviewable, dependent: :destroy

  # use friendly ids for urls
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged
  def slug_me_up
    "#{name} #{state.abbreviation} camping"
  end
  #Methods for accessing attributes
  def hashtag
    self.state.hashtag
  end
  def self.to_s
    self.name
  end
end
