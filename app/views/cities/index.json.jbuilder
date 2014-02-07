json.array!(@cities) do |city|
  json.extract! city, :id, :name, :description, :latitude, :longitude, :zoom, :state_id
  json.url city_url(city, format: :json)
end
