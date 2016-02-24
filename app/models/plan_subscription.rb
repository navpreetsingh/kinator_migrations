class PlanSubscription < ActiveRecord::Base
  belongs_to :group_detail
  belongs_to :api_subscription_plan
  has_many :channels_subscribed_in_plan
  has_many :plan_consumptions
end
