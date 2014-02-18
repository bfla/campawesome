json.array!(@fees) do |fee|
  json.extract! fee, :id, :campsite_id, :value, :per, :unit, :description, :comment
  json.url fee_url(fee, format: :json)
end
