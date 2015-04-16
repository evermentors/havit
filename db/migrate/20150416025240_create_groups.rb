class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false, index: true
      t.text :description, null: false, default: "", index: true
      t.string :password, null: false, default: ""
      t.integer :member_limit, null: false, default: 0
      t.integer :creator, null: false, index: true

      t.timestamps null: false
    end
  end
end
