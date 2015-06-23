module GoalsHelper
  def goal_percentage (goal)
    numerator = (Date.current - goal.created_at.to_date).to_i
    denominator = (goal.end_date - goal.created_at.to_date).to_i
    (numerator * 100 / denominator).to_f
  end

  def goal_period (goal)
    goal.created_at.strftime("%-y년 %-m월 %-d일") + ' ~ ' + goal.end_date.strftime("%-y년 %-m월 %-d일")
  end
end
