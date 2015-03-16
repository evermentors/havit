class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :description, null: false, default: ""
      t.references :user, index: true, null: false

      t.timestamps null: false
    end
  end
end
