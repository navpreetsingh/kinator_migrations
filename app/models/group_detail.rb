class GroupDetail < ActiveRecord::Base
	has_one :group_authentication_detail
	has_many :subscription_plans
	has_many :plan_consumptions, through: :subscription_plans
end
