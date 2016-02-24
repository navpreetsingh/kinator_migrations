class SubscriptionPlan < ActiveRecord::Base
  belongs_to :group_detail
  belongs_to :channel_detail
  has_many :plan_consumptions
end
