json.array!(@campsites) do |campsite|
  json.extract! campsite, :id, :name, :description, :org, :res_phone, :camp_phone, :res_url, :camp_url
  json.url campsite_url(campsite, format: :json)
end