class ConvertUserIntoCharacterInStatus < ActiveRecord::Migration
  def change
    rename_column :statuses, :user_id, :character_id
    Status.find_each do |st|
      st.update character_id: User.find(st.character_id).last_used_character
    end
  end
end
