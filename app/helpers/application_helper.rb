#encoding=utf-8

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

  def datestring (date)
    date.strftime("%-m월%d일")
  end
end
