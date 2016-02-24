class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.references :group_detail, index: true, foreign_key: true
      t.references :channel_detail, index: true, foreign_key: true
      t.integer :max_hits_allowed
      t.boolean :auto_renewal
      t.datetime :start_date
      t.integer :duration
      t.boolean :active

      t.timestamps null: false
    end
    add_index :subscription_plans, [:group_detail_id, :channel_detail_id], unique: true, name: "subscription_plan_details"
  end
end
