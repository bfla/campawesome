json.array!(@tags) do |tag|
  json.extract! tag, :id, :name, :type, :important, :red_flag
  json.url tag_url(tag, format: :json)
end
