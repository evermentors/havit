class WeeklyRetrospect < ActiveRecord::Base
  belongs_to :user
  belongs_to :weekly_goal

  validates :contents, presence: true
end
