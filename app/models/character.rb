class Character < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  has_many :monthly_goals, dependent: :destroy
  has_many :weekly_goals, dependent: :destroy
  has_many :weekly_retrospects, dependent: :destroy
  has_many :daily_goals, dependent: :destroy
  has_many :statuses, dependent: :destroy

  validates :group, presence: true
  validates :order, presence: true
end
