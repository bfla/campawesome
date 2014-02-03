json.array!(@destinations) do |destination|
  json.extract! destination, :id, :name, :description, :latitude, :longitude, :zoom, :state_id
  json.url destination_url(destination, format: :json)
end
