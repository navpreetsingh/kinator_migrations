class UserDetail < ActiveRecord::Base	
	self.table_name = "user_detail"
	has_and_belongs_to_many :group_details

	def group_ids
		self.user_json["group_detail"]["groupId"]
	end

	def role
		self.user_json.roleName
	end

	# has_many :subscription_plans
	# has_many :api_stats

	# def channel_details
	# 	ChannelDetail.find(self.subscription_plan.channel_ids)
	# end
end
