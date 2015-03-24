#encoding=utf-8

class MonthlyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_monthly_goal, only: [:show, :edit, :update, :destroy]

  def index
    @monthly_goals = MonthlyGoal.all
  end

  def show
  end

  def new
    @monthly_goal = current_user.monthly_goals.build
  end

  def edit
  end

  def create
    @monthly_goal = current_user.monthly_goals.build(monthly_goal_params)
    @monthly_goal.season = view_context.season_start(Time.current.to_date)

    respond_to do |format|
      if @monthly_goal.save
        format.html { redirect_to root_url, notice: 'Monthly goal was successfully created.' }
        format.json { render :show, status: :created, location: @monthly_goal }
      else
        format.html { render :new }
        format.json { render json: @monthly_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    notice_text = "이번 시즌의 목표를 변경했습니다: #{@monthly_goal.description} -> #{monthly_goal_params[:description]}"
    if @monthly_goal.update(monthly_goal_params)
      redirect_to root_url, notice: notice_text
    else
      render :edit
    end
  end

  def destroy
    @monthly_goal.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Monthly goal was successfully destroyed.' }
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
