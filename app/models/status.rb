class Status < ActiveRecord::Base
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: ["image/jpeg", "image/gif", "image/png"]

  validates :description, presence: true

  def liked_by?(user)
    likers.include?(user)
  end
end
