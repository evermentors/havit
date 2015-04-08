class StatusesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status, only: [:edit, :update, :destroy]

  def index
    @statuses = Status.all.order(created_at: :desc).page(params[:page])
    @commontator_thread_show = true
  end

  def edit
  end

  def create
    @status = current_user.statuses.build(status_params)

    if @status.save
      @daily_goal = DailyGoal.new(
        user: current_user,
        description: params[:next_daily_goal],
        goal_date: @status.verified_at.tomorrow)
      if @daily_goal.save
        redirect_to root_url
      else
        redirect_to root_url, notice: 'error: daily goal on new status'
      end
    else
      redirect_to root_url, notice: 'error: new status'
    end
  end

  def update
    if @status.update(status_params)
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_status
      @status = Status.find(params[:id])
    end

    def status_params
      params.require(:status).permit(:description, :user_id, :photo, :verified_at, :next_daily_goal)
    end
end
