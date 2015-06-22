module GoalsHelper
  def goal_percentage (goal)
    numerator = (Date.current - goal.created_at.to_date).to_i
    denominator = (goal.end_date - goal.created_at.to_date).to_i
    (numerator * 100 / denominator).to_f
  end
end
