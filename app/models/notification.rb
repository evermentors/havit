class Notification < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :link, presence: true
  validates :recipient, presence: true

  scope :unread, -> (user) { where("id > ? and (recipient = ? or (recipient = 0 and user_id != ?))", user.last_checked_notification, user.id, user.id).order(created_at: :desc).limit(5) }

  scope :read, -> (user) { where("id <= ? and (recipient = ? or (recipient = 0 and user_id != ?))", user.last_checked_notification, user.id, user.id).order(created_at: :desc).limit(5) }
end
