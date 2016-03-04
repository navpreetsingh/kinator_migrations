class ApiStat < ActiveRecord::Base
  belongs_to :group_detail
  belongs_to :channel_detail
end
