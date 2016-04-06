class Role < ActiveRecord::Base	
	self.table_name = "role"

	def users
		UserDetail.where("user_json#>>'roleId'='#{self.id}'")
	end
end