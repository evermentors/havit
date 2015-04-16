class ConvertUserIntoCharacterInWeeklyRetrospect < ActiveRecord::Migration
  def change
    WeeklyRetrospect.find_each do |wr|
      wr.update user_id: wr.user.last_used_character
    end
    rename_column :weekly_retrospects, :user_id, :character_id
  end
end
