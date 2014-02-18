json.array!(@taggings) do |tagging|
  json.extract! tagging, :id, :campsite_id, :tag_id, :user_id
  json.url tagging_url(tagging, format: :json)
end
