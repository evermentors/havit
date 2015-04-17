class AddGroupToStatus < ActiveRecord::Migration
  def change
    add_reference :statuses, :group, index: true

    Status.find_each do |status|
      status.update group_id: Group.find_by_name('Universe').id
    end

    add_foreign_key :statuses, :groups
    change_column_null :statuses, :group_id, true
  end
end
