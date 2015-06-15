#encoding=utf-8

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy, :can_join, :join, :members]

  def index
    redirect_to root_url unless current_user.email == 'evermentors@gmail.com'
    @groups = Group.all
  end

  def show
    if @group == universe
      if params.include?('status-id')
        redirect_to (root_url + '?status-id=' + params['status-id'])
      else
        redirect_to root_url
      end
    else
      character = Character.in_group(current_user, @group)
      if not character.blank?
        session[:last_used_character_id] = character.take.id
        @statuses = @group.members_statuses.page(params[:page]).per(10)

        render 'statuses/index', locals: { show_group: true }
      elsif @group.password.blank?
        @statuses = @group.members_statuses.page(params[:page]).per(10)
        render 'groups/not_joined', locals: { hidden: false }
      else
        render 'groups/not_joined', locals: { hidden: true }
      end

    end
  end

  def new
    @group = Group.new
    @submit_text = '그룹 만들기'
  end

  def edit
    redirect_to @group unless current_character.is_admin
    @submit_text = '그룹 정보 수정'
  end

  def join
    @group.characters.create user_id: current_user.id, order: (current_user.characters.count + 1), is_admin: false
    redirect_to @group, notice: "[#{@group.name}] 그룹에 가입했습니다."
  end

  def can_join
    @group_status = view_context.group_status(@group)
    if @group_status == 'need-passcode'
      if @group.password == params[:passcode]
        @passcode_status = 'right-passcode'
      else
        @passcode_status = 'wrong-passcode'
      end
    else
      @passcode_status = 'right-passcode'
    end
  end

  def members
    @members = @group.characters
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
    redirect_to @group unless current_character.is_admin
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
