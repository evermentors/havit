class AddForienKeysForGoalAndActionGoal < ActiveRecord::Migration
  def change
    add_reference :statuses, :goal, index: true
    add_foreign_key :statuses, :goals
    add_reference :statuses, :action_goal, index: true
    add_foreign_key :statuses, :action_goals
  end
end
