class ActionGoal < ActiveRecord::Base
  belongs_to :goal
  belongs_to :status
  has_one :action_status, class_name: "Status"

  validates :description, presence: true
end
