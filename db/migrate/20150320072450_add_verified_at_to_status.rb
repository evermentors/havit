class AddVerifiedAtToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :verified_at, :date, index: true

    Status.all.each do |st|
      st.verified_at = st.created_at
      st.save!
    end

    change_column :statuses, :verified_at, :date, null: false
  end
end
