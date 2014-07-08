module CampsiteFormatters

  # Related models
  def state_name
    if state_id == 1
      "Michigan"
    else
      state.name if self.state.name?
    end 
  end

  def hashtag
    state.hashtag if self.state.hashtag?
  end

  def city_name
    city.name if self.city.name?
  end

  def has_tribe?
    tribe.present? ? true : false
  end

  def tribes_json # FIXIT later.  I'm defining a behavior on another model...
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
    vibes.each { |tribe| icons << tribe.icon }
  end

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

  end

  # This takes a search query and distance, codes it into a coordinates, 
  # and returns nearby campgrounds

  def to_s
    self.name
  end
end