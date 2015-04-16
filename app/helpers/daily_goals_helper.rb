#encoding=utf-8

module DailyGoalsHelper
  def no_daily_goal? (cha=current_character, date=Time.current.to_date)
    DailyGoal.of(cha, date).count.zero?
  end

  def daily_goal (cha=current_character, date=Time.current.to_date)
    DailyGoal.of(cha, date).last
  end

  def daily_goal_description (date=Time.current.to_date, option='short', cha=current_character)
    dg = DailyGoal.of(cha, date).last
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
    DailyGoal.where("character_id = ? and goal_date <= ?", current_character.id, Date.today).order(created_at: :desc).first
  end
end
