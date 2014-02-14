class State < ActiveRecord::Base
  validates :name, :description, :latitude, :longitude, :zoom, :hashtag, presence: true
  validates :latitude, numericality: {greater_than: 0}
  validates :longitude, numericality: {less_than: 0}
  validates :zoom, numericality: true
  has_many :cities
  has_many :destinations
  has_many :campsites
  
  has_many :photos
  
  has_many :users
  
  def self.to_s
    self.name
  end

end
