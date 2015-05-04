#encoding=utf-8

class DailyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_goal, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @daily_goal = current_character.daily_goals.build(daily_goal_params)
    @daily_goal.goal_date = Date.current
    if @daily_goal.save
      redirect_to url, notice: "#{view_context.datestring}의 목표를 등록했습니다: #{@daily_goal.description}"
    else
      redirect_to url, alert: "목표 등록에 오류가 발생했습니다."
    end
  end

  def update
    notice_text = "#{view_context.datestring}의 목표를 변경했습니다: #{@daily_goal.description} -> #{daily_goal_params[:description]}"
    if @daily_goal.update(daily_goal_params)
      redirect_to url, notice: notice_text
    else
      render :edit
    end
  end

  def destroy
    @daily_goal.destroy
    respond_to do |format|
      format.html { redirect_to url, notice: 'Daily goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def on
    date = params[:date].to_date
    @description = view_context.daily_goal_description(date).gsub(/[\r\n]/, "\r"=>'', "\n"=>' nl ')
    @description = '목표가 없었습니다.' if @description.blank?
    @goal = view_context.daily_goal_description(date.tomorrow).gsub(/[\r\n]/, "\r"=>'', "\n"=>' ')
  end

  private
    def set_daily_goal
      @daily_goal = DailyGoal.find(params[:id])
    end

    def daily_goal_params
      params.require(:daily_goal).permit(:description, :goal_date, :user_id)
    end
end
