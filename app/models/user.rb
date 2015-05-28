class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  validates :slug, uniqueness: true

  before_create :update_user_attributes, unless: :skip_callbacks
  after_create :update_character, unless: :skip_callbacks

  include Gravtastic
  gravtastic(default: 'mm')

  has_many :characters, dependent: :destroy

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: ["image/jpeg", "image/gif", "image/png"]
  acts_as_commontator

  has_many :likes, dependent: :destroy
  has_many :liked_statuses, through: :likes, source: :status

  validates :name, presence: true

  def like!(status)
    liked_statuses << status unless likes?(status)
  end

  def unlike!(status)
    liked_statuses.destroy(status)
  end

  def likes?(status)
    liked_statuses.include?(status)
  end

  def normalize_friendly_id(string)
    string.to_ascii.downcase.gsub(" ", ".")
  end

  private
  def update_user_attributes
    universe = Group.find_by_name('Universe')
    character = Character.create order: 1, group_id: universe.id, user_id: User.first.id

    self.last_used_character = character.id
    self.last_checked_notification = Notification.last.id if Notification.last.present?
  end

  def update_character
    Character.find(self.last_used_character).update user_id: self.id
  end
end
