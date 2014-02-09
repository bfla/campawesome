json.array!(@listeds) do |listed|
  json.extract! listed, :id, :campsite_id, :list_id
  json.url listed_url(listed, format: :json)
end
