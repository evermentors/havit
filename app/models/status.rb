# encoding: UTF-8

class Status < ActiveRecord::Base
  default_scope { order(created_at: :desc) }
  paginates_per 10

  acts_as_commontable
  belongs_to :character
  belongs_to :group
  belongs_to :goal
  belongs_to :action_goal

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :notifications, dependent: :destroy
  has_one :next_action_goal, class_name: "ActionGoal", dependent: :destroy

  has_attached_file :photo, styles: { large: "1024x1024>", medium: "300x300>", thumb: "100x100>" }, source_file_options: { all: '-auto-orient' }
  validates_attachment_content_type :photo, content_type: ["image/jpeg", "image/gif", "image/png"]

  validates :description, presence: true
  validates :verified_at, presence: true
  validate :verified_at_should_be_past

  scope :during, -> (period, character) { where(verified_at: period, character: character).order(:verified_at) }
  scope :at, -> (date) { where(verified_at: date).order(created_at: :desc) }

  def verified_at_should_be_past
    errors.add(:verified_at, "미래의 실천을 인증할 수는 없습니다!") if
      verified_at > Date.current
  end

  def liked_by?(user)
    likers.include?(user)
  end

  def likers_other_than(user)
    likers.reject{ |liker| liker==user }
  end
end
