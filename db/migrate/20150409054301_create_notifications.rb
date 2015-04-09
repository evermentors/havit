class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.text :description, null: false
      t.text :link, null: false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
  end
end
