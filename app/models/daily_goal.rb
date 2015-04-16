class DailyGoal < ActiveRecord::Base
  belongs_to :character

  validates :description, presence: true
  validates :goal_date, presence: true

  scope :of, -> (character, date) { where(character: character, goal_date: date) }
end
