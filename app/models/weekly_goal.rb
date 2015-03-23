class WeeklyGoal < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :weeknum, presence: true

  scope :of, -> (user) { where(user_id: user.id, weeknum: WeeklyGoalsController.helpers.absolute_weeknum) }
end
