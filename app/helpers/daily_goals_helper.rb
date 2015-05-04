#encoding=utf-8

module DailyGoalsHelper
  def no_daily_goal? (cha=current_character, date=Date.current)
    DailyGoal.of(cha, date).count.zero?
  end

  def daily_goal (cha=current_character, date=Date.current)
    DailyGoal.of(cha, date).last
  end

  def daily_goal_description (date=Date.current, cha=current_character)
    dg = DailyGoal.of(cha, date).last
    if dg.present?
      description = dg.description
    else
      description = ''
    end
  end

  def last_daily_goal
    DailyGoal.where("character_id = ? and goal_date <= ?", current_character.id, Date.current).order(goal_date: :desc).first
  end
end
