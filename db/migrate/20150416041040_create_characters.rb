class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.references :group, index: true, null: false
      t.boolean :notify, null: false, default: true
      t.integer :order, null: false
      t.boolean :is_admin, null: false, default: false
      t.references :user, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :characters, :groups
    add_foreign_key :characters, :users
  end
end
