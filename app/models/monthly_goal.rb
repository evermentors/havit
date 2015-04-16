class MonthlyGoal < ActiveRecord::Base
  belongs_to :character

  validates :description, presence: true
  validates :season, presence: true

  scope :of, -> (character, season) { where(character: character, season: season) }
end
