json.array!(@reviews) do |review|
  json.extract! review, :id, :body, :user_id, :reviewable_id, :reviewable_type
  json.url review_url(review, format: :json)
end
