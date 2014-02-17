json.array!(@activities) do |activity|
  json.extract! activity, :id, :activity_type_id, :campsite_id, :description, :latitude, :longitude
  json.url activity_url(activity, format: :json)
end
