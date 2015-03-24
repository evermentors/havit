module WeeklyGoalsHelper
  def no_weekly_goal? (user, date=Time.current.to_date)
    WeeklyGoal.of(user, date.beginning_of_week).count.zero?
  end

  def weekly_goal (user, date=Time.current.to_date)
    WeeklyGoal.of(user, date.beginning_of_week).last
  end

  # TO BE MODIFIED
  # def relative_weeknum (date=Time.current.to_date)
  #   Time.current.to_date.strftime("%W").to_i - current_season.strftime("%W").to_i + 1
  # end
end
