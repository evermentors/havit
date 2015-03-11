class MonthlyGoalsController < ApplicationController
  before_action :set_monthly_goal, only: [:show, :edit, :update, :destroy]

  # GET /monthly_goals
  # GET /monthly_goals.json
  def index
    @monthly_goals = MonthlyGoal.all
  end

  # GET /monthly_goals/1
  # GET /monthly_goals/1.json
  def show
  end

  # GET /monthly_goals/new
  def new
    @monthly_goal = current_user.monthly_goals.build
  end

  # GET /monthly_goals/1/edit
  def edit
  end

  # POST /monthly_goals
  # POST /monthly_goals.json
  def create
    @monthly_goal = current_user.monthly_goals.build(monthly_goal_params)

    respond_to do |format|
      if @monthly_goal.save
        format.html { redirect_to @monthly_goal, notice: 'Monthly goal was successfully created.' }
        format.json { render :show, status: :created, location: @monthly_goal }
      else
        format.html { render :new }
        format.json { render json: @monthly_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monthly_goals/1
  # PATCH/PUT /monthly_goals/1.json
  def update
    respond_to do |format|
      if @monthly_goal.update(monthly_goal_params)
        format.html { redirect_to @monthly_goal, notice: 'Monthly goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @monthly_goal }
      else
        format.html { render :edit }
        format.json { render json: @monthly_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monthly_goals/1
  # DELETE /monthly_goals/1.json
  def destroy
    @monthly_goal.destroy
    respond_to do |format|
      format.html { redirect_to monthly_goals_url, notice: 'Monthly goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthly_goal
      @monthly_goal = MonthlyGoal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def monthly_goal_params
      params.require(:monthly_goal).permit(:description, :season)
    end
end
