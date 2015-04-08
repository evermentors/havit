module WeeklyRetrospectsHelper
  def weekly_retro_at(date, user=current_user)
    WeeklyRetrospect.for(weekly_goal(user, date))
  end

  def last_weekly_retro
    WeeklyRetrospect.where(user: current_user).order(:created_at).last
  end

  def day_passed_since_last_retro
    if last_weekly_retro.present?
      (Date.today - last_weekly_retro.weekly_goal.weeknum.end_of_week).to_i
    else
      (Date.today - first_verified_at.beginning_of_week.yesterday).to_i
    end
  end

  def last_week_of_season?
    last_weeklygoal_date = WeeklyGoal.where(user: current_user).order(:weeknum).last.weeknum
    last_weeklygoal_absolute_weeknum = last_weeklygoal_date.strftime("%W").to_i
    next_season_start_absolute_weeknum = season_start(last_weeklygoal_date.next_month).strftime("%W").to_i

    (next_season_start_absolute_weeknum - last_weeklygoal_absolute_weeknum) == 1
  end
end
