class State < ActiveRecord::Base

  validates :name, :abbreviation, :description, :latitude, :longitude, :zoom, :hashtag, presence: true
  validates :latitude, numericality: {greater_than: 0}
  validates :longitude, numericality: {less_than: 0}
  validates :zoom, numericality: true
  has_many :cities
  has_many :destinations
  has_many :campsites
  
  has_many :photos
  
  has_many :users

  # use friendly ids for urls
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged
  def slug_me_up
    "#{name} camping"
  end
  
  def self.to_s
    self.name
  end

end
