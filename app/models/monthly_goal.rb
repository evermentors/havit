class MonthlyGoal < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :season, presence: true
end
