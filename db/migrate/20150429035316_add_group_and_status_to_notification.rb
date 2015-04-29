class AddGroupAndStatusToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :group, index: true
    add_foreign_key :notifications, :groups
    add_reference :notifications, :status, index: true
    add_foreign_key :notifications, :statuses
  end
end
