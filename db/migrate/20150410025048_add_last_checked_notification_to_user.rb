class AddLastCheckedNotificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_checked_notification, :integer, default: 0, null: false
  end
end
