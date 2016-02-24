class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.references :group_detail, index: true, foreign_key: true
      t.text :channel_ids, array: true, default: []
      t.jsonb :max_hits_allowed
      t.boolean :channel_distribution
      t.jsonb :auto_renewal
      t.jsonb :start_date
      t.jsonb :duration
      t.jsonb :active

      t.timestamps null: false
    end
    # add_index :subscription_plans, [:group_detail_id, :channel_detail_id], unique: true, name: "subscription_plan_details"
  end
end
