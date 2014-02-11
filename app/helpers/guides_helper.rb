module GuidesHelper
  def set_has_tribe(campsites, tribe_id) # tests whether any campsites in a set have tribe with tribe_id
    bool = false
    campsites.each { |campsite| bool=true if campsite.has_tribe(tribe_id) }
    bool
  end
end