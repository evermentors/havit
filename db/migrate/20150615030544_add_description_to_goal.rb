class AddDescriptionToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :description, :text, null: false, default: ""
  end
end
