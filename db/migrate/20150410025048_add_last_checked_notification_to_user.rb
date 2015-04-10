class AddLastCheckedNotificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_checked_notification, :integer

    User.find_each do |user|
      user.update last_checked_notification: Notification.last.id
    end

    change_column :users, :last_checked_notification, :integer, null: false
  end
end
