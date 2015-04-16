class ConvertUserIntoCharacterInWeeklyRetrospect < ActiveRecord::Migration
  def change
    rename_column :weekly_retrospects, :user_id, :character_id
    WeeklyRetrospect.find_each do |wr|
      wr.update character_id: User.find(wr.character_id).last_used_character
    end
  end
end
