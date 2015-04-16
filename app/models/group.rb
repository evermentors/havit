class Group < ActiveRecord::Base
  has_many :characters, dependent: :destroy

  validates :name, presence: true
  validates :password, length: { maximum: 20 }
  validates :member_limit, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :creator, presence: true
end
