#encoding=utf-8

class WeeklyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weekly_goal, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    notice_text = "#{weekstring}의 목표를 변경했습니다: #{@weekly_goal.description} -> #{weekly_goal_params[:description]}"
    if @weekly_goal.update(weekly_goal_params)
      redirect_to root_url, notice: notice_text
    else
      render :edit
    end
  end

  def destroy
    @weekly_goal.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Weekly goal was successfully destroyed.' }
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
end
