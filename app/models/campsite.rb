class Campsite < ActiveRecord::Base
  # name:string, org:string, description:text, 
  # state_id:integer, latititude:float, longitude:float
  # res_phone:string, camp_phone:string, res_url:string, camp_url:string, 
  # reservable:boolean, walkin:boolean
  belongs_to :state
  belongs_to :city
  
  has_many :beens, as: :beenable, dependent: :destroy
  has_many :wants, dependent: :destroy
  has_many :listeds, dependent: :destroy
  has_many :lists, through: :listed
  has_many :ratings, as: :ratable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

  has_many :vibes, dependent: :destroy
  has_many :tribes, through: :vibes
  has_many :photos

  #has_many :tribes
  validates :name, :org, :state_id, :city_id, :latitude, :longitude, presence: { message:'is required' }
  validates :res_phone, :camp_phone, numericality: { message:'must be a number', allow_blank:true }
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
  def tribes_json
    tribe_ids = Array.new
    self.vibes.each { |vibe| tribe_ids << vibe.tribe.id }
    tribe_ids = tribe_ids.to_json
  end
  def primary_icon(style)
    self.vibes.first.tribe.icon(style)
  end
  def has_tribe(tribe_id)
    bool = false
    self.tribes.each { |tribe| bool = true if tribe.id == tribe_id }
    bool
  end
  def icons
    self.vibes.each { |tribe| icons << tribe.icon }
  end
  def beened(user)
    self.beens.find_by_user(user)
  end
  def geojsonify
    tribe_ids = Array.new
    self.vibes.each { |vibe| tribe_ids << vibe.tribe.id }
    geojson = {
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [self.longitude, self.latitude]
      },
      properties: {
        title: self.name,
        tribes: tribe_ids,
        url: 'http://example.com',
        :'marker-color' => "\#09b",
        :'marker-symbol' => 'campsite',
        :'marker-size' => 'large'
      }
    }
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

  def self.to_s
    self.name
  end

end
