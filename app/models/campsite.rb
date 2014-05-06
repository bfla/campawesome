class Campsite < ActiveRecord::Base
  # name:string, org:string, description:text, 
  # state_id:integer, latititude:float, longitude:float
  # res_phone:string, camp_phone:string, res_url:string, camp_url:string, 
  # reservable:boolean, walkin:boolean
  belongs_to :state
  belongs_to :city
  
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

  #has_many :tribes
  validates :name, :org, :state_id, :latitude, :longitude, presence: { message:'is required' }
  #validates :res_phone, :camp_phone, numericality: { message:'must be a number', allow_blank:true }
  validates :latitude, numericality: { greater_than: 0, message:'must be a positive' }
  validates :longitude, numericality: { less_than: 0, message:'must be a negative number' }
  reverse_geocoded_by :latitude, :longitude
  
  before_validation :reverse_geocode #reverse geocode it before friendlyId needs the city
  #before_save :check_ranking
  before_save :seed_blanks
  #before_validation :fetch_city_and_state
  #after_validation :reverse_geocode #auto-fetch address
  default_scope order('avg_rating DESC')

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

  end

  # import CSV file
  def self.import(file)
    #CSV.foreach(file.path, headers:true) { |row| Campsite.create! row.to_hash }
    CSV.foreach(file.path, headers:true) do |row|
      Campsite.create! row.to_hash
      sleep(0.5)
    end
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

  def self.name_search(keywords)
    if keywords
      where('name LIKE ?', "%#{keywords}%") || Campsite.none
    else
      Campsite.none
    end
  end

  def self.to_s
    self.name
  end

  # Use friendly ids for urls
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged
  def slug_me_up
    "#{name} in #{city.name} #{state.abbreviation} camping"
  end

  private

    def seed_blanks
      self.avg_rating = rand(3.5..4.2).round(2) if self.ratings.blank? && self.avg_rating.blank?
      sum = 0
    end

    # app/models/place.rb
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

    def resave_avg_rating
      if !self.ratings.blank?
        sum = 0
        self.ratings.each {|rating| sum = sum + rating.value}
        self.avg_rating = sum / self.ratings.size
      end
    end

    #def check_ranking BAD TRIGGERS ENDLESS LOOP
      #self.city.rerank if self.avg_rating_changed?
    #end

end
