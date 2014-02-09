json.array!(@wants) do |want|
  json.extract! want, :id, :campsite_id, :user_id
  json.url want_url(want, format: :json)
end
