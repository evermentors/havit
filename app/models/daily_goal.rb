class DailyGoal < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :goal_date, presence: true

  scope :of, -> (user, date) { where(user_id: user.id, goal_date: date) }
end
