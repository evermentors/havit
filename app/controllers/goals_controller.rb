#encoding=utf-8

class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal, only: [:show, :on]

  def show
    session[:last_used_character_id] = @goal.character.id
    @statuses = @goal.statuses.page(params[:page])
    @group = @goal.group
  end

  def on
    @date = params[:date].to_date
  end

  private

    def set_goal
      @goal = Goal.find(params[:id])
    end
end
