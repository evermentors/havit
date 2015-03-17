class AddLikesCountToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :likes_count, :integer, null: false, default: 0

    Status.find_each do |status|
      Status.reset_counters status.id, :likes
    end
  end
end
