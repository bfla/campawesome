class Destination < ActiveRecord::Base
  belongs_to :state
  validates :name, :description, :latitude, :longitude, :zoom, presence: true
  validates :latitude, numericality: {greater_than: 0}
  validates :longitude, numericality: {less_than: 0}
  validates :zoom, numericality: true

  def hashtag
    self.state.hashtag
  end
  def self.to_s
    self.name
  end
end
