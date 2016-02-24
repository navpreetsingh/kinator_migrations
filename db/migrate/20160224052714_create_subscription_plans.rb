class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.references :group_detail, index: true, foreign_key: true
      t.text :channel_ids, array: true, default: []
      t.jsonb :start_date
      t.jsonb :end_date
      t.boolean :opted_distributed_plan
      t.jsonb :max_hits_allowed      
      t.boolean :auto_renewal           
      t.jsonb :exhausted
      t.jsonb :exhausted_date
      t.jsonb :hits_consumed

      t.timestamps null: false
    end
  end
end