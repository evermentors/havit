module WeeklyGoalsHelper
  def no_weekly_goal? (cha=current_character, date=Date.today)
    WeeklyGoal.of(cha, date.beginning_of_week).count.zero?
  end

  def weekly_goal (cha=current_character, date=Date.today)
    WeeklyGoal.of(cha, date.beginning_of_week).last
  end

  def last_weekly_goal
    WeeklyGoal.where(character: current_character).order(:weeknum).last
  end

  def relative_weeknum (date=Date.today)
    date.strftime("%W").to_i - season_start(date).strftime("%W").to_i + 1
  end
end
