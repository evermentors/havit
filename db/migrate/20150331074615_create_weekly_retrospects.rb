class CreateWeeklyRetrospects < ActiveRecord::Migration
  def change
    create_table :weekly_retrospects do |t|
      t.references :user, index: true
      t.references :weekly_goal, index: true
      t.references :rapidfire_answer_group, index: true

      t.timestamps null: false
    end
    add_foreign_key :weekly_retrospects, :users
    add_foreign_key :weekly_retrospects, :weekly_goals
    add_foreign_key :weekly_retrospects, :rapidfire_answer_groups
  end
end
