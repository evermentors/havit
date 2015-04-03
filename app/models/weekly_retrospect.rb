class WeeklyRetrospect < ActiveRecord::Base
  belongs_to :user
  belongs_to :weekly_goal

  serialize :questions, Hash
  serialize :answers, Hash
end
