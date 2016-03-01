class GroupDetail < ActiveRecord::Base	
	self.table_name = "group_detail"

	has_many :subscription_plans
	has_many :api_stats

	def channel_details
		ChannelDetail.find(self.subscription_plan.channel_ids)
	end
end
