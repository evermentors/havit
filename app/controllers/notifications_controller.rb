class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @unread_notifications = Notification.unread(current_user).reverse
    need_more_notification = 5 - @unread_notifications.count
    @read_notifications = Notification.read(current_user).limit(need_more_notification).reverse
  end

  def read
    current_user.update(last_checked_notification: params[:id])
    render nothing: true
  end

  def pull_unread
    @unread_notifications = Notification.unread(current_user).reverse
  end

  private
end
