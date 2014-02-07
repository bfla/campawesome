json.array!(@photos) do |photo|
  json.extract! photo, :id, :title, :license_type, :license_text, :user_id, :campsite_id, :city_id, :state_id, :destination_id, :caption
  json.url photo_url(photo, format: :json)
end
