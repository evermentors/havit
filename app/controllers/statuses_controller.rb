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

    target_goal = Goal.find(params[:status_goal_id])
    @status.goal = target_goal
    @status.action_goal = target_goal.last_action_goal

    if @status.save
      if params[:next_action_goal].present?
        next_action_goal_description = params[:next_action_goal]
      else
        next_action_goal_description = @status.action_goal.description
      end

      next_action_goal = ActionGoal.new(
        description: next_action_goal_description,
        goal: target_goal,
        status: @status)
      if next_action_goal.save
        unless current_character.group.home?
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
        redirect_to url, notice: 'error: next action goal on new status'
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
