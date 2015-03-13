class DailyGoal < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :weekday, presence: true, inclusion: 1..7

  scope :of, -> (user) { where(user_id: user.id) }
end
