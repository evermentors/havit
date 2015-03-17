class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :status, counter_cache: true

  validates :user, presence: true, uniqueness: { scope: :status }
  validates :status, presence: true
end
