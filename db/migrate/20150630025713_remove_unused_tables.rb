class RemoveUnusedTables < ActiveRecord::Migration
  def change
    drop_table :monthly_goals, force: :cascade
    drop_table :weekly_goals, force: :cascade
    drop_table :daily_goals, force: :cascade
    drop_table :weekly_retrospects, force: :cascade
  end
end
