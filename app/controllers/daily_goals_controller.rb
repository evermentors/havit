class DailyGoalsController < ApplicationController
  before_action :set_daily_goal, only: [:show, :edit, :update, :destroy]

  # GET /daily_goals
  # GET /daily_goals.json
  def index
    @daily_goals = DailyGoal.all
  end

  # GET /daily_goals/1
  # GET /daily_goals/1.json
  def show
  end

  # GET /daily_goals/new
  def new
    @daily_goal = current_user.daily_goals.build
    @daily_goal.weekday = _weekday
  end

  # GET /daily_goals/1/edit
  def edit
  end

  # POST /daily_goals
  # POST /daily_goals.json
  def create
    @daily_goal = current_user.daily_goals.build(daily_goal_params)

    respond_to do |format|
      if @daily_goal.save
        format.html { redirect_to @daily_goal, notice: 'Daily goal was successfully created.' }
        format.json { render :show, status: :created, location: @daily_goal }
      else
        format.html { render :new }
        format.json { render json: @daily_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_goals/1
  # PATCH/PUT /daily_goals/1.json
  def update
    respond_to do |format|
      if @daily_goal.update(daily_goal_params)
        format.html { redirect_to @daily_goal, notice: 'Daily goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_goal }
      else
        format.html { render :edit }
        format.json { render json: @daily_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_goals/1
  # DELETE /daily_goals/1.json
  def destroy
    @daily_goal.destroy
    respond_to do |format|
      format.html { redirect_to daily_goals_url, notice: 'Daily goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_goal
      @daily_goal = DailyGoal.find(params[:id])
    end

    def _weekday
      Time.current.to_date.day%7
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_goal_params
      params.require(:daily_goal).permit(:description, :weekday, :user_id)
    end
end
