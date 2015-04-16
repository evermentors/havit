class ConvertUserIntoCharacterInWeeklyDailyGoal < ActiveRecord::Migration
  def change
    rename_column :weekly_goals, :user_id, :character_id
    WeeklyGoal.find_each do |goal|
      goal.update character_id: User.find(goal.character_id).last_used_character
    end

    rename_column :daily_goals, :user_id, :character_id
    DailyGoal.find_each do |goal|
      goal.update character_id: User.find(goal.character_id).last_used_character
    end
  end
end
