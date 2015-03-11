class CreateMonthlyGoals < ActiveRecord::Migration
  def change
    create_table :monthly_goals do |t|
      t.text :description, null:false, default: ""
      t.date :season, null:false, index: true, default: Time.current.to_date.beginning_of_month
      t.references :user, index: true, null:false

      t.timestamps null: false
    end
  end
end