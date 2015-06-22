class AddNextActionGoalToStatus < ActiveRecord::Migration
  def change
    add_reference :action_goals, :status, index: true
    add_foreign_key :action_goals, :statuses
  end
end
