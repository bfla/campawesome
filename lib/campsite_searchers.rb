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
end