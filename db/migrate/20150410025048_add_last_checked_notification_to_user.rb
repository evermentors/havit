class AddLastCheckedNotificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_checked_notification, :integer, default: 1, null: false
  end
end
