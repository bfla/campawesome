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

  def get_google_image
    goog_photo_bool, goog_license, goog_img_url = false, nil, nil # initialize the output variables
    gplaces_key = "AIzaSyB9mHzeQJxtkMkn_UkKAOs00Hkg2Y9qKds"
    # run a Google Places search & parse it into a ruby object
    gplace_url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{self.latitude},#{self.longitude}&radius=8000&sensor=false&key=#{gplaces_key}"
    puts "sending GPlaces request to #{gplace_url}"
    gplace_response = Net::HTTP.get_response(URI.parse(gplace_url))
    puts "received a response from Google Places" if gplace_response
    gplaces = JSON.parse(gplace_response.body)

    # test if Google has any photos and if so fetch it
    gplaces["results"].each do |gplace| # for each object returned from Google
      if gplace["photos"] and gplace["types"] # if the object has photos and is categorized
        puts "Google Places returned a photo"
        acceptable_types = ["park", "campground", "natural_feature", "rv_park", "locality", "point_of_interest"]
        gplace["types"].each do |type|
          if acceptable_types.include? type # if the GPlaces object is in the right category
            puts "Google Places returned a photo of an acceptable type"
            goog_photo_bool = true
            photo_obj = gplace["photos"].first
            goog_license = photo_obj["html_attributions"] if photo_obj["html_attributions"]
            photo_ref = photo_obj["photo_reference"]
            # Create request to display the photo
            target_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{photo_ref}&sensor=true&key=#{gplaces_key}"
            goog_img_url = target_url
            #response = Net::HTTP.get_response(URI.parse(target_url))
            #goog_img = response.body
            break # since we now have a photo, break the loop
          end
        end
      end
    end
    puts "GoogPhotoBool:#{goog_photo_bool}, GoogLic:#{goog_license}, GoogImgURL:#{goog_img_url}"
    return goog_photo_bool, goog_license, goog_img_url
  end

end