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
        render 'statuses/index'
      else
        render text: '니 그룹이 아님'
      end
    end
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
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
