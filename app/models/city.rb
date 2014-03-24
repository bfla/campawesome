class City < ActiveRecord::Base
  
  belongs_to :state
  has_many :campsites
  has_many :photos
  validates :name, :latitude, :longitude, :zoom, presence: true
  validates :latitude, numericality: {greater_than: 0}
  validates :longitude, numericality: {less_than: 0}
  validates :zoom, numericality: true

  # use friendly ids for urls
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged
  def slug_me_up
    "#{name} #{state.abbreviation} camping"
  end

  def hashtag
    self.state.hashtag
  end
  def self.to_s
    self.name
  end
end
