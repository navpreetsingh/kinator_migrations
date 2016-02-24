class GroupDetail < ActiveRecord::Base
	has_one :group_authentication_detail
	has_one :subscription_plan
	has_many :plan_consumptions, through: :subscription_plan
	


	def channel_details
		ChannelDetail.find(self.subscription_plan.channel_ids)
	end
end
