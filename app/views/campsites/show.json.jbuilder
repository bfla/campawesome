json.extract! @campsite, :id, :name, :org, :latitude, :longitude, :res_phone, :camp_phone, :res_url, :camp_url, :reservable, :walkin, :avg_rating, :city_rank

json.city_count @campsite.city.campsites.size

json.state @campsite.state, :name, :abbreviation

json.city @campsite.city, :name

json.tribes @campsite.tribes do |tribe|
  json.id tribe.id
  json.vibe tribe.adjective
end

json.nearbys @nearbys do |nearby|
  json.id nearby.id
  json.name nearby.name
  json.url url_for(nearby)
end

json.photos @campsite.photos do |photo|
  json.name photo.title
  json.license_type photo.license_type
  json.license_text photo.license_text
  json.caption photo.caption
  json.date_added photo.created_at
  json.url photo.photo_file.url(:large)
end

json.reviews @campsite.reviews do |review|
  json.body review.body
  json.user_name review.user.first_name
  #json.rating_value review.rating.value #This triggers an error if the rating cannot be found...
end

json.tags @campsite.tags do |tag|
  json.name tag.name
  json.type tag.category
end
