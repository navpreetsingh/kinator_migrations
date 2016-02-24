class ChannelDetail < ActiveRecord::Base	
	has_many :api_stats

	def group_details
		GroupDetail.joins(:subscription_plan).where("'#{self.id}' = ANY (channel_ids)")
	end
end
