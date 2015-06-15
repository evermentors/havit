class CreateActionGoals < ActiveRecord::Migration
  def change
    create_table :action_goals do |t|
      t.text :description, null: false
      t.references :goal, index: true

      t.timestamps null: false
    end
    add_foreign_key :action_goals, :goals
  end
end
