class Group < ActiveRecord::Base
  searchkick word_middle: [:name], text_middle: [:description]

  has_many :characters, dependent: :destroy
  has_many :members, through: :characters, source: :user
  # has_many :members_goals, through: :characters, source: :goal
  # has_many :members_statuses, through: :characters, source: :statuses

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }
  validates :password, length: { maximum: 20 }
  validates :member_limit, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :creator, presence: true
end
