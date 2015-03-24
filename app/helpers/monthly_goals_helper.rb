module MonthlyGoalsHelper
  def no_monthly_goal? (user=current_user, date=Time.current.to_date)
    MonthlyGoal.of(user, season_start(date)).count.zero?
  end

  def monthly_goal (user=current_user, date=Time.current.to_date)
    MonthlyGoal.of(user, season_start(date)).last
  end

  def season_start (date=Time.current.to_date)
    season_start = date.beginning_of_month
    wnum_today = date.strftime("%W").to_i
    wnum_beginning = season_start.strftime("%W").to_i

    if season_start.wday != 1 and wnum_today - wnum_beginning == 0
      season_start = season_start.prev_month
    end

    season_start += 1 until season_start.wday == 1
    return season_start
  end
end
