#encoding=utf-8

class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    if @group == universe
      redirect_to root_url
    else
      character = Character.in_group(current_user, @group)
      if character.present?
        @statuses = Status.from(@group).page(params[:page])
        session[:last_used_character_id] = character.id
        render 'statuses/index', locals: { show_group: true }
      else
        render text: '니 그룹이 아님'
      end
    end
  end

  def new
    @group = Group.new
    @submit_text = '그룹 만들기'
  end

  def edit
    @submit_text = '그룹 정보 수정'
  end

  def members
  end

  def create
    @group = Group.new(group_params)
    @group.creator = current_user.id
    @group.member_limit = 0 if @group.member_limit.blank?

    if @group.save
      @group.characters.create user_id: current_user.id, order: (current_user.characters.count + 1), is_admin: true
      redirect_to @group, notice: "[#{@group.name}] 그룹을 만들었습니다."
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: "[#{@group.name}] 그룹의 정보를 변경했습니다."
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_group
      if Group.find_by_id(params[:id]).nil?
        render text: '그룹이 존재하지 않음'
      else
        @group = Group.find(params[:id])
      end
    end

    def group_params
      params.require(:group).permit(:name, :description, :password, :member_limit)
    end
end
