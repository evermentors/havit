class Group < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :password, presence: true, length: { maximum: 20 }
  validates :member_limit, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :creator, presence: true
end
