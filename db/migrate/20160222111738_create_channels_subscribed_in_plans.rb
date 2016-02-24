class CreateChannelsSubscribedInPlans < ActiveRecord::Migration
  def change
    create_table :channels_subscribed_in_plans do |t|
      t.references :channel_detail, index: true, foreign_key: true
      t.references :plan_subscription, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :channels_subscribed_in_plans, [:channel_detail_id, :plan_subscription_id], unique: true, name: "channel_susbscription_in_plan"
  end
end
