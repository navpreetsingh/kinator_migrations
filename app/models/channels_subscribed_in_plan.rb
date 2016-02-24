class ChannelsSubscribedInPlan < ActiveRecord::Base
  belongs_to :channel_detail
  belongs_to :plan_subscription
end
