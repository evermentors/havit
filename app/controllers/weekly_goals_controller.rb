#encoding=utf-8

class WeeklyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weekly_goal, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @weekly_goal = current_character.weekly_goals.build(weekly_goal_params)
    @weekly_goal.weeknum = Date.current.beginning_of_week

    @daily_goal = current_character.daily_goals.build(daily_goal_params)
    @daily_goal.goal_date = Date.current

    if @weekly_goal.save and @daily_goal.save
      redirect_to url, notice: "#{view_context.weekstring_short Date.current}의 목표를 등록했습니다: #{@weekly_goal.description}"
    else
      redirect_to url, alert: "목표 등록에 오류가 발생했습니다."
    end
  end

  def update
    if @weekly_goal.update(weekly_goal_params)
      @description = @weekly_goal.description.gsub(/[\r\n]/, "\r"=>'', "\n"=>' nl ')
      respond_to do |format|
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @weekly_goal.destroy
    respond_to do |format|
      format.html { redirect_to url, notice: 'Weekly goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_weekly_goal
      @weekly_goal = WeeklyGoal.find(params[:id])
    end

    def weekly_goal_params
      params.require(:weekly_goal).permit(:description, :weeknum, :user_id)
    end

    def daily_goal_params
      params.require(:daily_goal).permit(:description)
    end
end
