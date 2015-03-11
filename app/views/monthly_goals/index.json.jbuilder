json.array!(@monthly_goals) do |monthly_goal|
  json.extract! monthly_goal, :id, :description, :season
  json.url monthly_goal_url(monthly_goal, format: :json)
end
