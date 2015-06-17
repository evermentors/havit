#encoding=utf-8

class Goal < ActiveRecord::Base
  belongs_to :character
  belongs_to :group

  has_many :action_goals, dependent: :destroy
  has_many :statuses, dependent: :destroy

  validates :end_date, presence: true
  validates :theme, presence: true
  validates :description, presence: true
  validates :type, presence: true
  validates :type_specific_fields, presence: true
  # validate :end_date_sholud_be_future

  scope :active, -> { where("end_date >= ?", Date.current) }

  def end_date_sholud_be_future
    errors.add(:end_date, "실천 종료일을 제대로 골라주세요.") if
      end_date < Date.current
  end

  def done_today?
    if statuses.blank?
      false
    else
      statuses.first.verified_at.today?
    end
  end
end

class CheckGoal < Goal
end

class ProgressGoal < Goal
end

class ScoreGoal < Goal
end

class MilestoneGoal < Goal
end
