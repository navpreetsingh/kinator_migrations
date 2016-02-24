class GroupDetail < ActiveRecord::Base	
	has_one :subscription_plan
	has_many :api_stats
	


	def channel_details
		ChannelDetail.find(self.subscription_plan.channel_ids)
	end
end
