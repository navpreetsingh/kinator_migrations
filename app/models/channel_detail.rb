class ChannelDetail < ActiveRecord::Base
	has_many :channels_subscribed_in_plan
	has_many :plan_subscriptions, through: :channels_subscribed_in_plan	
	has_many :group_details, through: :plan_subscriptions
	has_many :plan_consumptions, through: :plan_subscriptions
end
