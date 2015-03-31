class WeeklyRetrospect < ActiveRecord::Base
  belongs_to :user
  belongs_to :weekly_goal
  belongs_to :rapidfire_answer_group
end
