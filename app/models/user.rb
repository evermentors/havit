class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :monthly_goals, dependent: :destroy
  has_many :weekly_goals, dependent: :destroy
  has_many :daily_goals, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
