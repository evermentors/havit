module WeeklyRetrospectsHelper
  def weekly_retro_at(date, user=current_user)
    WeeklyRetrospect.for(weekly_goal(user, date))
  end
end
