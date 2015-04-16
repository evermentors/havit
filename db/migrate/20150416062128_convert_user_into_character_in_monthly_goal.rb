class ConvertUserIntoCharacterInMonthlyGoal < ActiveRecord::Migration
  def change
    MonthlyGoal.find_each do |goal|
      goal.update user_id: goal.user.last_used_character
    end
    rename_column :monthly_goals, :user_id, :character_id
  end
end
