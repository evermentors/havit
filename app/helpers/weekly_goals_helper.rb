module WeeklyGoalsHelper
  def no_weekly_goal? (user)
    WeeklyGoal.of(user).count.zero?
  end

  def weekly_goal (user)
    WeeklyGoal.of(user).last
  end

  def relative_weeknum
    Time.current.to_date.strftime("%W").to_i - current_season.strftime("%W").to_i + 1
  end

  def absolute_weeknum
    Time.current.to_date.beginning_of_week
  end
end
