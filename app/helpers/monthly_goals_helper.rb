module MonthlyGoalsHelper
  def no_monthly_goal? (cha=current_character, date=Date.today)
    MonthlyGoal.of(cha, season_start(date)).count.zero?
  end

  def monthly_goal (cha=current_character, date=Date.today)
    MonthlyGoal.of(cha, season_start(date)).last
  end

  def season_start (date=Date.today)
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
