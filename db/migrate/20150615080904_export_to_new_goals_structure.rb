class ExportToNewGoalsStructure < ActiveRecord::Migration
  def change
    MonthlyGoal.find_each do |mg|
      Goal.create! end_date: mg.season.end_of_month, character: mg.character, type: 'CheckGoal', type_specific_fields: {"num_actions_per_week":5}, group: mg.character.group, description: "#{mg.season.end_of_month.strftime('%-Y년 %-m월 %-d일')}까지 주당 5회 #{mg.description}", theme: mg.description
    end

    Status.find_each do |st|
      mg = MonthlyGoal.of(st.character, season_start(st.verified_at)).last

      if DailyGoal.of(st.character, st.verified_at).blank?
        description = mg.description
      else
        description = DailyGoal.of(st.character, st.verified_at).last.description
      end

      target_goal = Goal.find_by_theme(mg.description)

      ag = ActionGoal.create! description: description, goal: target_goal, created_at: st.created_at.yesterday

      st.update goal: target_goal, action_goal: ag
    end
  end

  def season_start (date)
    season_start = date.beginning_of_month
    wnum_today = date.strftime("%W").to_i
    wnum_beginning = season_start.strftime("%W").to_i

    if season_start.wday != 1 and wnum_today - wnum_beginning == 0
      season_start = season_start.prev_month
    end

    season_start += 1 until season_start.wday == 1
    return season_start
  end
end
