#encoding=utf-8

module ApplicationHelper
  def no_monthly_goal? (user)
    MonthlyGoal.of(user).count.zero?
  end

  def monthly_goal (user)
    MonthlyGoal.of(user).last
  end

  def no_weekly_goal? (user)
    WeeklyGoal.of(user).count.zero?
  end

  def weekly_goal (user)
    WeeklyGoal.of(user).last
  end

  def no_daily_goal? (user)
    DailyGoal.of(user).count.zero?
  end

  def daily_goal (user)
    DailyGoal.of(user).last
  end

  def datestring (date)
    date.strftime("%-m월%d일")
  end
end
