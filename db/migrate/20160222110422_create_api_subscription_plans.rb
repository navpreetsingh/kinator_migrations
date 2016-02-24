class CreateApiSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :api_subscription_plans do |t|
      t.string :max_hits_allowed
      t.string :cost_per_hit
      t.string :duration

      t.timestamps null: false
    end
  end
end
