class CreateDailyGoals < ActiveRecord::Migration
  def change
    create_table :daily_goals do |t|
      t.text :description, null:false, default: ""
      t.date :goal_date, null:false, index: true
      t.references :user, index: true, null:false

      t.timestamps null: false
    end
  end
end
