class MonthlyGoal < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :season, presence: true

  scope :of, -> (user) { where(user_id: user.id, season: MonthlyGoalsController.helpers.current_season) }
end
