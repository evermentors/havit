class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.date :end_date, null: false
      t.string :theme, null: false
      t.string :type, null: false, index: true
      t.json :type_specific_fields, null: false
      t.references :character, index: true
      t.references :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :goals, :characters
    add_foreign_key :goals, :groups
  end
end
