class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :update_last_checked_notification

  include Gravtastic
  gravtastic

  has_many :characters, dependent: :destroy

  acts_as_commontator

  private
  def update_last_checked_notification
    self.last_checked_notification = Notification.last.id
  end
end
