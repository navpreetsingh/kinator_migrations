class GroupDetail < ActiveRecord::Base
	has_one :group_authentication_detail
	has_many :plan_subscriptions
	has_many :api_subscription_plans, through: :plan_subscriptions
	has_many :channels_subscribed_in_plans, through: :plan_subscriptions
	has_many :channel_details, through: :channels_subscribed_in_plans
	has_many :plan_consumptions, through: :plan_subscriptions
end
