class AddMaxHitsToGroupAuthenticationDetails < ActiveRecord::Migration
  def change
  	add_column :group_authentication_details, :max_hits_allowed, :integer, default: -1
  end
end
