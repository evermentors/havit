#encoding=utf-8

class MonthlyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_monthly_goal, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @monthly_goal.update(monthly_goal_params)
      @description = @monthly_goal.description.gsub(/[\r\n]/, "\r"=>'', "\n"=>' nl ')
      respond_to do |format|
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @monthly_goal.destroy
    respond_to do |format|
      format.html { redirect_to url, notice: 'Monthly goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_monthly_goal
      @monthly_goal = MonthlyGoal.find(params[:id])
    end

    def monthly_goal_params
      params.require(:monthly_goal).permit(:description, :season)
    end
end
