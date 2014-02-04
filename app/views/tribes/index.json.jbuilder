json.array!(@tribes) do |tribe|
  json.extract! tribe, :id, :name, :description, :vibe
  json.url tribe_url(tribe, format: :json)
end
