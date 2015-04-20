# encoding: UTF-8

class Status < ActiveRecord::Base
  acts_as_commontable
  belongs_to :character

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: ["image/jpeg", "image/gif", "image/png"]

  validates :description, presence: true
  validates :verified_at, presence: true
  validate :verified_at_should_be_past

  class << self
    def during(period, character)
      where(verified_at: period, character: character).order(:verified_at)
    end

    def at(date, character)
      where(verified_at: date, character: character).order(:created_at)
    end
  end

  def verified_at_should_be_past
    errors.add(:verified_at, "미래의 실천을 인증할 수는 없습니다!") if
      verified_at > Date.current
  end

  def liked_by?(user)
    likers.include?(user)
  end
end
