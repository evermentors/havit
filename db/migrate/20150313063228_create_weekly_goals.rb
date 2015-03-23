class CreateWeeklyGoals < ActiveRecord::Migration
  def change
    create_table :weekly_goals do |t|
      t.text :description, null:false, default: ""
      t.date :weeknum, null:false, index: true
      t.references :user, index:true, null:false

      t.timestamps null: false
    end
  end
end
