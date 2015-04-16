class AddLastUsedCharacterToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_used_character, :integer

    User.find_each do |user|
      user.update last_used_character: Character.find_by(user_id: user.id).id
    end

    change_column :users, :last_used_character, :integer, null: false
  end
end
