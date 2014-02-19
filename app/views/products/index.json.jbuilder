json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :points, :quantity
  json.url product_url(product, format: :json)
end
