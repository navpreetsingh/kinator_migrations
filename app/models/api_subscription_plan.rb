class ApiSubscriptionPlan < ActiveRecord::Base
	has_many :plan_subscriptions
	has_many :group_details, through: :plan_subscriptions
	has_many :plan_consumptions, through: :plan_subscriptions
end
