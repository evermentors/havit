class StatusesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status, only: [:edit, :update, :destroy]

  def index
    @statuses = Status.all.order(created_at: :desc).page(params[:page])
  end

  def edit
  end

  def create
    @status = current_user.statuses.build(status_params)
    # 일단 무조건 오늘로만 verify되게 함
    @status.verified_at = Time.current.to_date

    if @status.save
      redirect_to root_url
    else
      redirect_to root_url
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
      params.require(:status).permit(:description, :user_id, :photo, :verified_at)
    end
end
