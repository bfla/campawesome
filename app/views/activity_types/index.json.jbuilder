json.array!(@activity_types) do |activity_type|
  json.extract! activity_type, :id, :name
  json.url activity_type_url(activity_type, format: :json)
end
