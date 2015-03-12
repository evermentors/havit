module ApplicationHelper
  def no_goal?
    MonthlyGoal.of(current_user).count.zero?
  end

  def current_goal
    MonthlyGoal.of(current_user).last
  end
end
