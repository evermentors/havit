class MonthlyGoal < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :season, presence: true

  scope :of, -> (user, season) { where(user_id: user.id, season: season) }
end
