class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :status

  validates :description, presence: true
  validates :recipient, presence: true

  class << self
    def unread(user)
      where("id > ? and #{notify_condition}",
        user.last_checked_notification,
        user.id,
        groups_to_notify(user),
        user.id)
      .order(created_at: :desc).limit(5)
    end

    def read(user)
      where("id <= ? and #{notify_condition}",
        user.last_checked_notification,
        user.id,
        groups_to_notify(user),
        user.id)
      .order(created_at: :desc).limit(5)
    end

    def groups_to_notify(user)
      groups = []
      user.characters.each do |cha|
        groups << cha.group.id if cha.notify
      end
      return groups
    end

    def notify_condition
      'user_id != ? and group_id in (?) and (recipient = ? or recipient = 0)'
    end
  end
end
