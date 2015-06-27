class Character < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  has_many :weekly_retrospects, dependent: :destroy
  has_many :statuses, dependent: :destroy
  has_many :goals, dependent: :destroy

  validates :group, presence: true
  validates :order, presence: true

  scope :in_group, -> (user, group) { where(user: user, group: group) }
  scope :admin, -> (group) { where(group: group, is_admin: true).take }
  scope :notified, -> { where(notify: true) }
  scope :home, -> (user) { where(user: user, group: Group.find_by_name('Universe')).take }
end
