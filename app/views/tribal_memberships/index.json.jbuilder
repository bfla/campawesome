json.array!(@tribal_memberships) do |tribal_membership|
  json.extract! tribal_membership, :id, :tribe_id, :user_id
  json.url tribal_membership_url(tribal_membership, format: :json)
end
