class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :update_user_attributes, unless: :skip_collbacks
  after_create :update_character, unless: :skip_collbacks

  include Gravtastic
  gravtastic

  has_many :characters, dependent: :destroy

  acts_as_commontator

  has_many :likes, dependent: :destroy
  has_many :liked_statuses, through: :likes, source: :status

  def like!(status)
    liked_statuses << status unless likes?(status)
  end

  def unlike!(status)
    liked_statuses.destroy(status)
  end

  def likes?(status)
    liked_statuses.include?(status)
  end

  private
  def update_user_attributes
    universe = Group.find_by_name('Universe')
    character = Character.create order: 1, group_id: universe.id, user_id: User.first.id

    self.last_used_character = character.id
    self.last_checked_notification = Notification.last.id
  end

  def update_character
    Character.find(self.last_used_character).update user_id: self.id
  end
end
