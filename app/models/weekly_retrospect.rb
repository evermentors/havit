class WeeklyRetrospect < ActiveRecord::Base
  belongs_to :user
  belongs_to :weekly_goal

  serialize :questions, Hash
  serialize :answers, Hash

  class << self
    def for (weekly_goal)
      find_by_weekly_goal_id(weekly_goal)
    end
  end
end
