json.array!(@characters) do |character|
  json.extract! character, :id, :group_id, :notify, :order, :is_admin
  json.url character_url(character, format: :json)
end
