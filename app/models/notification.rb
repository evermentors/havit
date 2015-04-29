class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :status

  validates :description, presence: true
  validates :recipient, presence: true

  scope :unread, -> (user) { where("id > ? and user_id != ? and (recipient = ? or recipient = 0)", user.last_checked_notification, user.id, user.id).order(created_at: :desc).limit(5) }

  scope :read, -> (user) { where("id <= ? and user_id != ? and (recipient = ? or recipient = 0)", user.last_checked_notification, user.id, user.id).order(created_at: :desc).limit(5) }

  scope :related_to, -> (status_id) { where(link: "/statuses/#{status_id}") }
end
