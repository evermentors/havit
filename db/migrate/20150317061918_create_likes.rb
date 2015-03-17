class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, index: true, null: false
      t.references :status, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :likes, :users, on_delete: :cascade
    add_foreign_key :likes, :statuses, on_delete: :cascade

    add_index :likes, [:user_id, :status_id], unique: true
    add_index :likes, [:status_id, :user_id], unique: true
  end
end
