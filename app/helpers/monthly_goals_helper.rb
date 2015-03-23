module MonthlyGoalsHelper
  def no_monthly_goal? (user)
    MonthlyGoal.of(user).count.zero?
  end

  def monthly_goal (user)
    MonthlyGoal.of(user).last
  end

  def current_season
    date = Time.current.to_date.beginning_of_month
    wnum_today = Time.current.to_date.strftime("%W").to_i
    wnum_beginning = date.strftime("%W").to_i

    if date.wday != 1 and wnum_today - wnum_beginning == 0
      date = date.prev_month
    end

    date += 1 until date.wday == 1
    return date
  end
end
