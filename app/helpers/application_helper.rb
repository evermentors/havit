module ApplicationHelper
  def no_monthly_goal?
    MonthlyGoal.of(current_user).count.zero?
  end

  def current_monthly_goal
    MonthlyGoal.of(current_user).last
  end

  def no_weekly_goal?
    WeeklyGoal.of(current_user).count.zero?
  end

  def current_weekly_goal
    WeeklyGoal.of(current_user).last
  end

  def no_daily_goal?
    DailyGoal.of(current_user).count.zero?
  end

  def current_daily_goal
    DailyGoal.of(current_user).last
  end
end
