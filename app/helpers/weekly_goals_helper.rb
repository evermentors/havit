module WeeklyGoalsHelper
  def no_weekly_goal? (cha=current_character, date=Time.current.to_date)
    WeeklyGoal.of(cha, date.beginning_of_week).count.zero?
  end

  def weekly_goal (cha=current_character, date=Time.current.to_date)
    WeeklyGoal.of(cha, date.beginning_of_week).last
  end

  def last_weekly_goal
    WeeklyGoal.where(character: current_character).order(created_at: :desc).first
  end

  def relative_weeknum (date=Time.current.to_date)
    date.strftime("%W").to_i - season_start(date).strftime("%W").to_i + 1
  end
end
