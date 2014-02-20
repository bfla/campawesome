json.array!(@reward_orders) do |reward_order|
  json.extract! reward_order, :id, :product_id, :user_id
  json.url reward_order_url(reward_order, format: :json)
end
