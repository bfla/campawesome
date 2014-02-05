json.array!(@beens) do |been|
  json.extract! been, :id, :campsite_id, :user_id
  json.url been_url(been, format: :json)
end
