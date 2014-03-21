json.extract! @campsite, :id, :name, :org, :latitude, :longitude, :res_phone, :camp_phone, :res_url, :camp_url, :reservable, :walkin, :avg_rating, :city_rank

json.state @campsite.state, :name

json.city @campsite.city, :name

json.tribes @campsite.tribes, :id, :vibe

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
  json.rating_value review.rating.value
end
