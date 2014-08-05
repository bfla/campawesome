class Campsite < ActiveRecord::Base
  include CampsiteFinders #lib/campsite_searchers.rb for scopes
  extend CampsiteSearchers #lib/campsite_searchers.rb for searches
  include CampsiteFormatters #lib/campsite_formatters.rb for formatting data

  belongs_to :state
  belongs_to :city, counter_cache: :campsites_count
  has_many :beens, as: :beenable, dependent: :destroy
  has_many :wants, as: :wantable, dependent: :destroy
  has_many :listeds, as: :listable, dependent: :destroy
  has_many :lists, through: :listed
  has_many :ratings, as: :ratable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :photos
  has_many :vibes, dependent: :destroy
  has_many :tribes, through: :vibes
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :activities
  has_many :fees, dependent: :destroy

  validates :name, :org, :state_id, :latitude, :longitude, presence: { message:'is required' }
  validates :latitude, numericality: { greater_than: 0, message:'must be a positive' }
  validates :longitude, numericality: { less_than: 0, message:'must be a negative number' }
  before_validation :reverse_geocode #reverse geocode it before friendlyId needs the city
  before_save :seed_blanks
<<<<<<< HEAD
  #before_validation :fetch_city_and_state
  #after_validation :reverse_geocode #auto-fetch address
  default_scope order('avg_rating DESC')

  def self.to_chlite_csv(campsites)
    require 'csv'
    CSV.generate do |csv|
      keys = ["ch_id", "latitude", "longitude", "name", "owner", "camp_phone", "tribes", "tags", "url", "res_url"]
      csv << keys
      campsites.each do |c|
        csv_dict = {
          ch_id: c.id,
          latitude: c.latitude,
          longitude: c.longitude,
          name: c.name,
          owner: c.org,
          camp_phone: c.camp_phone,
          tribes: c.tribes.to_json,
          tags: c.tags.to_json,
          url: c.camp_url,
          res_url: c.res_url,
        }
        csv << csv_dict.values
      end
    end
  end

  def self.not_in_city(city)
    where.not(city_id: city.id)
  end

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
    if self.tribes.first.blank? 
      false 
    else 
      self.tribes.first.icon(style)
    end
  end

  def has_tribe(tribe_id)
    bool = false
    self.tribes.each { |tribe| bool = true if tribe.id == tribe_id }
    bool
  end

  def icons
    self.vibes.each { |tribe| icons << tribe.icon }
  end
  #def avg_rating
    #sum = 0
    #self.ratings.each {|rating| sum = sum + rating.value}
    #sum / self.ratings.size
  #end
  #def rank

  #end
  def geojsonify
    tribe_ids = Array.new
    self.vibes.each { |vibe| tribe_ids << vibe.tribe.id }
    self.camp_phone.blank? ? phone = self.res_phone : phone = self.camp_phone

    geojson = {
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [self.longitude, self.latitude]
      },
      properties: {
        title: self.name,
        campsiteId:self.id,      
        org: self.org,
        tribes: tribe_ids,
        url: "campsites/#{self.slug}",
        popup_url: "/campsites/#{self.slug}",
        tribe_img: self.primary_icon(:small),
        # Extra data for iOS search:
        phone: phone,
        reservable: self.reservable,
        walkin: self.walkin,
        #reservable: self.reservable,
        #walkins: self.walkins,
        #avg_rating: self.avg_rating,
        #ranking: self.rank,
        #tribes_dict: self.tribes.each {|tribe| self.tribes << tribe.to_json },
        #reviews_dict: self.reviews.each { |review| self.reviews << review.to_json },
        :'marker-color' => "\#09b",
        :'marker-symbol' => 'campsite',
        :'marker-size' => 'large'
      }
    }
=======
  reverse_geocoded_by :latitude, :longitude
>>>>>>> refactor

  default_scope order('avg_rating DESC')
  delegate :hashtag, to: :state, prefix: true

  def self.import(file) # import CSV file
    #CSV.foreach(file.path, headers:true) { |row| Campsite.create! row.to_hash }
    CSV.foreach(file.path, headers:true) do |row|
      Campsite.create! row.to_hash
      sleep(0.5)
    end
  end

  def resave_avg_rating #calculate new avg_rating (usually when a new rating is saved)
    if !self.ratings.blank?
      sum = 0
      self.ratings.each {|rating| sum = sum + rating.value}
      self.avg_rating = sum / self.ratings.size
    end
  end

  # Use friendly ids for urls
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged
  def slug_me_up
    if name
      "#{name} in #{city.name} #{state.abbreviation} camping"
    else
      ""
    end
  end

  private

    def seed_blanks #autogenerate an avg_rating if there are none
      self.avg_rating = rand(3.5..4.2).round(2) if self.ratings.blank? && self.avg_rating.blank?
      sum = 0
    end

    #custom reverse geocoding method stores city and address in the campsite model
    reverse_geocoded_by :latitude, :longitude do |campsite, results|
      if geo = results.first
        campsite.address = geo.address
        city_name = geo.city

        if campsite.city_id.blank? && City.find_by(name:city_name, state_id:campsite.state_id).nil?
          # if the city doesn't exist, make it and add it to the campsite
          city = City.create(name:city_name, state_id:campsite.state_id, latitude:campsite.latitude, longitude:campsite.longitude, zoom:9)
          campsite.city_id = city.id
        elsif campsite.city_id.blank?
          # if the city already exists, find it and add it to the campsite
          city = City.find_by(name:city_name, state_id:campsite.state_id)
          campsite.city_id = city.id
        end

      end
    end

end
