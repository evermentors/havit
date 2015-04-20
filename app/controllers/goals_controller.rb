#encoding=utf-8

class GoalsController < ApplicationController
  before_action :authenticate_user!

  def create
    @monthly_goal = current_character.monthly_goals.build(monthly_goal_params)
    @monthly_goal.season = view_context.season_start(Date.current)

    @weekly_goal = current_character.weekly_goals.build(weekly_goal_params)
    @weekly_goal.weeknum = Date.current.beginning_of_week

    @daily_goal = current_character.daily_goals.build(daily_goal_params)
    @daily_goal.goal_date = Date.current

    if @monthly_goal.save and @weekly_goal.save and @daily_goal.save
      redirect_to url, notice: '목표가 정상적으로 등록되었습니다.'
    else
      redirect_to url, alert: "목표 등록에 오류가 발생했습니다."
    end
  end

  private
    def monthly_goal_params
      params.require(:monthly_goal).permit(:description)
    end
    def weekly_goal_params
      params.require(:weekly_goal).permit(:description)
    end
    def daily_goal_params
      params.require(:daily_goal).permit(:description)
    end
end
