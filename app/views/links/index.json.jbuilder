json.array!(@links) do |link|
  json.extract! link, :id, :anchor, :href, :title, :city_id, :destination_id, :state_id
  json.url link_url(link, format: :json)
end
