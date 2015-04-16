class ConvertUserIntoCharacterInMonthlyGoal < ActiveRecord::Migration
  def change
    rename_column :monthly_goals, :user_id, :character_id
    MonthlyGoal.find_each do |goal|
      goal.update character_id: User.find(goal.character_id).last_used_character
    end
  end
end
