class Character < ActiveRecord::Base
  belongs_to :group

  validates :group, presence: true
  validates :notify, presence: true
  validates :order, presence: true
  validates :is_admin, presence: true
end
