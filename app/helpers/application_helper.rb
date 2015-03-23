#encoding=utf-8

module ApplicationHelper

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
