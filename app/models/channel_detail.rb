class ChannelDetail < ActiveRecord::Base
	# has_many :subscription_plans	
	# has_many :group_details, through: :subscription_plans
	# has_many :plan_consumptions, through: :subscription_plans

	def group_details
		GroupDetail.joins(:subscription_plan).where("'#{self.id}' = ANY (channel_ids)")
	end
end
