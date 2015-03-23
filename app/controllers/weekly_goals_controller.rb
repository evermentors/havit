class WeeklyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_weekly_goal, only: [:show, :edit, :update, :destroy]

  def index
    @weekly_goals = WeeklyGoal.all
  end

  def show
  end

  def new
    @weekly_goal = current_user.weekly_goals.build
  end

  def edit
  end

  def create
    @weekly_goal = current_user.weekly_goals.build(weekly_goal_params)

    respond_to do |format|
      if @weekly_goal.save
        format.html { redirect_to statuses_url, notice: 'Weekly goal was successfully created.' }
        format.json { render :show, status: :created, location: @weekly_goal }
      else
        format.html { render :new }
        format.json { render json: @weekly_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @weekly_goal.update(weekly_goal_params)
        format.html { redirect_to statuses_url, notice: 'Weekly goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @weekly_goal }
      else
        format.html { render :edit }
        format.json { render json: @weekly_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @weekly_goal.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Weekly goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_weekly_goal
      @weekly_goal = WeeklyGoal.find(params[:id])
    end

    def _weeknum
      (Time.current.to_date.day/7.0).ceil
    end
    def weekly_goal_params
      params.require(:weekly_goal).permit(:description, :weeknum, :user_id)
    end
end
