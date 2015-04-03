class WeeklyRetrospect < ActiveRecord::Base
  belongs_to :user
  belongs_to :weekly_goal

  serialize :contents, Hash
end
