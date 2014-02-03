class Campsite < ActiveRecord::Base
  # name:string, org:string, description:text, 
  # state_id:integer, latititude:float, longitude:float
  # res_phone:string, camp_phone:string, res_url:string, camp_url:string, 
  # reservable:boolean, walkin:boolean
  belongs_to :state
  #has_many :tribe_associations
  validates :name, :org, :state_id, :latitude, :longitude, presence: { message:'is required' }
  validates :res_phone, :camp_phone, numericality: { message:'must be a number' }
  validates :latitude, numericality: { greater_than: 0, message:'must be a positive' }
  validates :longitude, numericality: { less_than: 0, message:'must be a negative number' }
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode #auto-fetch address

  # This returns the name of the Campsite's state
  def state_name
    self.state.name if self.state.name?
  end
  def hashtag
    self.state.hashtag if self.state.hashtag?
  end

  # This takes a search query and distance, codes it into a coordinates, 
  # and returns nearby campgrounds
  def self.search(search, distance)
    if search
      coordinates = Geocoder.coordinates(search)
      campsites = Campsite.near(coordinates, distance)
    else
      find(:all)
    end
  end

  def geojsonify
    geojson = {
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [self.longitude, self.latitude]
      },
      properties: {
        title: self.name,
        url: 'http://example.com',
        :'marker-color' => "\#09b",
        :'marker-symbol' => 'campsite',
        :'marker-size' => 'large'
      }
    }
  end

  def self.to_s
    self.name
  end

end
