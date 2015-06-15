class ActionGoal < ActiveRecord::Base
  belongs_to :goal
  has_one :status
end
