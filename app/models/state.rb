class State < ActiveRecord::Base
  validates :name, :description, :map_latitude, :map_longitude, :zoom, :hashtag, presence: true
  validates :map_latitude, numericality: {greater_than: 0}
  validates :map_longitude, numericality: {less_than: 0}
  validates :zoom, numericality: true
  has_many :cities
  has_many :destinations
  has_many :campsites
  
  def self.to_s
    self.name
  end

end
