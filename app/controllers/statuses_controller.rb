#encoding=utf-8

class StatusesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status, only: [:edit, :update, :destroy]
  before_action :set_group

  def index
    @statuses = Status.from(universe).page(params[:page])
    session[:last_used_character_id] = Character.in_group(current_user, universe).id
  end

  def edit
  end

  def create
    @status = current_character.statuses.build(status_params)
    @status.group = @group

    if @status.save
      if view_context.no_daily_goal?(current_character, @status.verified_at.tomorrow)
        @daily_goal = DailyGoal.new(
          character: current_character,
          description: params[:next_daily_goal],
          goal_date: @status.verified_at.tomorrow)
      else
        @daily_goal = view_context.daily_goal(current_character, @status.verified_at.tomorrow)
        @daily_goal.description = params[:next_daily_goal]
      end

      if @daily_goal.save
        notification = Notification.new(
          user: current_user,
          recipient: 0,
          description: "#{view_context.datestring @status.verified_at}의 실천 인증을 올렸습니다.",
          link: status_path(@status))
        notification.save
        redirect_to url
      else
        redirect_to url, notice: 'error: daily goal on new status'
      end
    else
      redirect_to url, notice: 'error: new status'
    end
  end

  def update
    if @status.update(status_params)
      redirect_to url
    else
      render :edit
    end
  end

  def destroy
    Notification.related_to(@status.id).destroy_all
    @status.destroy
    respond_to do |format|
      format.html { redirect_to url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_status
      @status = Status.find(params[:id])
    end

    def set_group
      @group ||= current_character.group
    end

    def status_params
      params.require(:status).permit(:description, :user_id, :photo, :verified_at, :next_daily_goal)
    end
end
