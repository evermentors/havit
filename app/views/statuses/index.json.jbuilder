json.array!(@statuses) do |status|
  json.extract! status, :id, :description, :user_id
  json.url status_url(status, format: :json)
end
