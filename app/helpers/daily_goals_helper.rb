module DailyGoalsHelper
  def no_daily_goal? (user=current_user, date=Time.current.to_date)
    DailyGoal.of(user, date).count.zero?
  end

  def daily_goal (user=current_user, date=Time.current.to_date)
    DailyGoal.of(user, date).last
  end

  def last_daily_goal
    DailyGoal.where(user_id: current_user.id).order(created_at: :desc).first
  end
end
