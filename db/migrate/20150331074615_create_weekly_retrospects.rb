class CreateWeeklyRetrospects < ActiveRecord::Migration
  def change
    create_table :weekly_retrospects do |t|
      t.references :user, index: true
      t.references :weekly_goal, index: true
      t.text :questions, null: false
      t.text :answers, null: false

      t.timestamps null: false
    end
    add_foreign_key :weekly_retrospects, :users
    add_foreign_key :weekly_retrospects, :weekly_goals
  end
end
