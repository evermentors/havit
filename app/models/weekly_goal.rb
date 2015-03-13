class WeeklyGoal < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :weeknum, presence: true, inclusion: 1..5

  scope :of, -> (user) { where(user_id: user.id) }
end
