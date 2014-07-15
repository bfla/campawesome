class City < ActiveRecord::Base
  
  belongs_to :state
  has_many :campsites, :order => 'avg_rating DESC'
  has_many :photos
  has_many :links
  reverse_geocoded_by :latitude, :longitude
  validates :name, :latitude, :longitude, :zoom, presence: true
  validates :latitude, numericality: {greater_than: 0}
  validates :longitude, numericality: {less_than: 0}
  validates :zoom, numericality: true

  #Scopes
  def self.by_name
    order('name ASC')
  end

  # use friendly ids for urls
  extend FriendlyId
  friendly_id :slug_me_up, use: :slugged
  def slug_me_up
    "#{name} #{state.abbreviation} camping"
  end

  def hashtag
    self.state.hashtag
  end

  def self.to_s
    self.name
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |city|
        csv << city.attributes.values_at(*column_names)
      end
    end
  end

  def rerank
    self.campsites.each_with_index do |c, index|
      c.city_rank = index + 1
      c.save()
    end
    #elsif contenders.count = 1
      #contenders.first.city_rank = 1
      #campsite = contenders.first
      #campsite.save()
    #end
  end

end
