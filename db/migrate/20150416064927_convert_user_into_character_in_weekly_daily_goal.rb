class ConvertUserIntoCharacterInWeeklyDailyGoal < ActiveRecord::Migration
  def change
    WeeklyGoal.find_each do |goal|
      goal.update user_id: goal.user.last_used_character
    end
    rename_column :weekly_goals, :user_id, :character_id

    DailyGoal.find_each do |goal|
      goal.update user_id: goal.user.last_used_character
    end
    rename_column :daily_goals, :user_id, :character_id
  end
end
