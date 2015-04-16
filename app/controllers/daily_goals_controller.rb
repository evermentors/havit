#encoding=utf-8

class DailyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_goal, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @daily_goal = current_character.daily_goals.build(daily_goal_params)
    @daily_goal.goal_date = Time.current.to_date
    if @daily_goal.save
      redirect_to root_url, notice: "#{view_context.datestring}의 목표를 등록했습니다: #{@daily_goal.description}"
    else
      redirect_to root_url, alert: "목표 등록에 오류가 발생했습니다."
    end
  end

  def update
    notice_text = "#{view_context.datestring}의 목표를 변경했습니다: #{@daily_goal.description} -> #{daily_goal_params[:description]}"
    if @daily_goal.update(daily_goal_params)
      redirect_to root_url, notice: notice_text
    else
      render :edit
    end
  end

  def destroy
    @daily_goal.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Daily goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def on
    date = params[:date].to_date
    datestr = "#{view_context.datestring date} #{view_context.weekdaystring date}: "
    @description = "#{datestr}#{view_context.daily_goal_description date, 'long'}"
    @goal = view_context.daily_goal_description(date.tomorrow)
  end

  private
    def set_daily_goal
      @daily_goal = DailyGoal.find(params[:id])
    end

    def daily_goal_params
      params.require(:daily_goal).permit(:description, :goal_date, :user_id)
    end
end
