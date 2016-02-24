class PlanConsumption < ActiveRecord::Base
  belongs_to :plan_subscription
  belongs_to :group_detail
end
