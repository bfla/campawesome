module CampsiteSearchers
  def search(search, distance)
    if search
      coordinates = Geocoder.coordinates(search)
      campsites = Campsite.near(coordinates, distance)
    else
      find(:all)
    end
  end

  def name_search(keywords)
    if keywords
      where('LOWER(name) LIKE ?', "%#{keywords.downcase}%") || Campsite.none
    else
      Campsite.none
    end
  end

  def map_search(keywords, zoom, distance)
    zoom = zoom || 10
    distance = distance || 30
    coordinates = Geocoder.coordinates(keywords)
    campsites = Campsite.near(coordinates, distance).includes(:tribes, :taggings, :city, :state).first(50)
    campsites ||= Campsite.name_search(params[:keywords])
    return campsites, zoom, distance, coordinates
  end

  def get_recommended(campsites, user)
    recommended = Array.new
    campsites.each do |campsite|
      if campsite.tribes.include? user.tribe
        recommended << campsite
      end
    end
    return recommended
  end

end