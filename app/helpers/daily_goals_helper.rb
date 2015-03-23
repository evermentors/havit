module DailyGoalsHelper
  def no_daily_goal? (user)
    DailyGoal.of(user).count.zero?
  end

  def daily_goal (user)
    DailyGoal.of(user).last
  end

  def today
    Time.current.to_date
  end
end
