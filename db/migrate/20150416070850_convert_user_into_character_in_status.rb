class ConvertUserIntoCharacterInStatus < ActiveRecord::Migration
  def change
    Status.find_each do |st|
      st.update user_id: st.user.last_used_character
    end
    rename_column :statuses, :user_id, :character_id
  end
end
