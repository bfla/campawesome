json.array!(@vibes) do |vibe|
  json.extract! vibe, :id, :campsite_id, :tribe_id
  json.url vibe_url(vibe, format: :json)
end
