class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.like!(status)
    respond_to do |format|
      format.html { redirect_to status }
      format.js
    end
  end

  def destroy
    current_user.unlike!(status)
    respond_to do |format|
      format.html { redirect_to status }
      format.js
    end
  end

  private

  def status
    @status ||= Status.find(params[:status_id])
  end
end
