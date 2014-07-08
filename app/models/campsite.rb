class Campsite < ActiveRecord::Base
  include CampsiteFinders #lib/campsite_searchers.rb for scopes
  extend CampsiteSearchers #lib/campsite_searchers.rb for searches
  include CampsiteFormatters #lib/campsite_formatters.rb for formatting data
  # name:string, org:string, description:text, 
  # state_id:integer, latititude:float, longitude:float
  # res_phone:string, camp_phone:string, res_url:string, camp_url:string, 
  # reservable:boolean, walkin:boolean
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

  delegate :hashtag, to: :city, prefix: true

  # import CSV file
  def self.import(file)
    #CSV.foreach(file.path, headers:true) { |row| Campsite.create! row.to_hash }
    CSV.foreach(file.path, headers:true) do |row|
      Campsite.create! row.to_hash
      sleep(0.5)
    end
  end

  def resave_avg_rating #calculate new avg_rating when a new rating is saved
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

    #def check_ranking
      #self.city.rerank if self.avg_rating_changed?
    #end

end
