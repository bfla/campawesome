class State < ActiveRecord::Base
  # name:string
  validates :name, :description, :map_latitude, :map_longitude, :map_distance, presence: true
  validates :map_latitude, numericality: {greater_than: 0}
  validates :map_longitude, numericality: {less_than: 0}
  validates :map_distance, numericality: true
  has_many :campsites

  def self.to_s
    self.name
  end

end
