class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Gravtastic
  gravtastic

  acts_as_commontator

  has_many :monthly_goals, dependent: :destroy
  has_many :weekly_goals, dependent: :destroy
  has_many :weekly_retrospects, dependent: :destroy
  has_many :daily_goals, dependent: :destroy
  has_many :statuses, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_statuses, through: :likes, source: :status
  has_many :notifications, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def like!(status)
    liked_statuses << status unless likes?(status)
  end

  def unlike!(status)
    liked_statuses.destroy(status)
  end

  def likes?(status)
    liked_statuses.include?(status)
  end
end
