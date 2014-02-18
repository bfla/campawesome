json.array!(@tags) do |tag|
  json.extract! tag, :id, :name, :category, :important, :red_flag
  json.url tag_url(tag, format: :json)
end
