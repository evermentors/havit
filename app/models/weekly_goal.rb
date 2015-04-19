class WeeklyGoal < ActiveRecord::Base
  belongs_to :character

  has_one :weekly_retrospect, dependent: :destroy

  validates :description, presence: true
  validates :weeknum, presence: true

  scope :of, -> (character, date) { where(character: character, weeknum: date).order(:weeknum) }
end
