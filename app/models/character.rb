class Character < ActiveRecord::Base
  belongs_to :group, dependent: :destroy

  acts_as_commontator

  has_many :monthly_goals, dependent: :destroy
  has_many :weekly_goals, dependent: :destroy
  has_many :weekly_retrospects, dependent: :destroy
  has_many :daily_goals, dependent: :destroy
  has_many :statuses, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_statuses, through: :likes, source: :status

  validates :group, presence: true
  validates :notify, presence: true
  validates :order, presence: true
  validates :is_admin, presence: true

  def like!(status)
    liked_statuses << status unless likes?(status)
  end

  def unlike!(status)
    liked_statuses.destroy(status)
  end

  def likes?(status)
    liked_statuses.include?(status)
  end
end
