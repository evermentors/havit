#encoding=utf-8

module DailyGoalsHelper
  def no_daily_goal? (user=current_user, date=Time.current.to_date)
    DailyGoal.of(user, date).count.zero?
  end

  def daily_goal (user=current_user, date=Time.current.to_date)
    DailyGoal.of(user, date).last
  end

  def daily_goal_description (date=Time.current.to_date, option='short', user=current_user)
    dg = DailyGoal.of(user, date).last
    if dg.present?
      description = dg.description
      description = "[#{dg.description}] 인증하기" if option == 'long'
    else
      description = ''
      description = '목표가 없었습니다.' if option == 'long'
    end
    return description
  end

  def last_daily_goal
    DailyGoal.where(user_id: current_user.id).order(created_at: :desc).first
  end
end
