json.array!(@ratings) do |rating|
  json.extract! rating, :id, :ratable_id, :ratable_type, :value, :user
  json.url rating_url(rating, format: :json)
end
