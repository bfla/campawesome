json.array!(@cities) do |city|
  json.extract! city, :id, :name, :desciption, :latitude, :longitude, :zoom, :state_id
  json.url city_url(city, format: :json)
end
