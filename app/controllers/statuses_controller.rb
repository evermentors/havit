#encoding=utf-8

class StatusesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status, only: [:show, :update, :destroy]

  def index
    @statuses = universe.members_statuses.page(params[:page])
    @group = universe
    session[:last_used_character_id] = Character.in_group(current_user, universe).take.id
  end

  def show
  end

  def create
    @status = current_character.statuses.build(status_params)
    @status.group = current_character.group

    target_goal = Goal.find_by_theme(view_context.monthly_goal(current_character, @status.verified_at).description)
    @status.goal = target_goal

    if params[:next_daily_goal].present?
      next_daily_goal = params[:next_daily_goal]
    else
      next_daily_goal = view_context.last_daily_goal.description
    end

    action_goal = ActionGoal.create! description: next_daily_goal, goal: target_goal, created_at: @status.verified_at.tomorrow
    @status.action_goal = action_goal

    if @status.save
      if params[:next_daily_goal].present?
        next_daily_goal = params[:next_daily_goal]
      else
        next_daily_goal = view_context.last_daily_goal.description
      end

      if view_context.no_daily_goal?(current_character, @status.verified_at.tomorrow)
        @daily_goal = DailyGoal.new(
          character: current_character,
          description: next_daily_goal,
          goal_date: @status.verified_at.tomorrow)
      else
        @daily_goal = view_context.daily_goal(current_character, @status.verified_at.tomorrow)
        @daily_goal.description = next_daily_goal
      end

      if @daily_goal.save
        if current_character.group != universe
          Notification.create!(
            user: current_user,
            recipient: 0,
            description: "'#{current_character.group.name}' 그룹에서 #{view_context.datestring @status.verified_at}의 실천 인증을 올렸습니다.",
            link: group_path(current_character.group),
            group: current_character.group,
            status: @status)

          view_context.notify_to_group(@status)
        end
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
      respond_to do |format|
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to url, notice: '실천 인증이 성공적으로 삭제되었습니다.' }
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
