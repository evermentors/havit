#encoding=utf-8

class GoalsController < ApplicationController
  before_action :authenticate_user!

  def create
    @monthly_goal = current_user.monthly_goals.build(monthly_goal_params)
    @monthly_goal.season = view_context.season_start(Time.current.to_date)

    @weekly_goal = current_user.weekly_goals.build(weekly_goal_params)
    @weekly_goal.weeknum = Time.current.to_date.beginning_of_week

    @daily_goal = current_user.daily_goals.build(daily_goal_params)
    @daily_goal.goal_date = Time.current.to_date

    if @monthly_goal.save and @weekly_goal.save and @daily_goal.save
      redirect_to root_url, notice: '목표가 정상적으로 등록되었습니다.'
    else
      flash.now[:error] = "목표 등록에 오류가 발생했습니다."
      render :season
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
