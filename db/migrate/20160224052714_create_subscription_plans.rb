class CreateSubscriptionPlans < ActiveRecord::Migration
  def change
    create_table :subscription_plans do |t|
      t.references :group_detail, index: true, table_name: "group_detail"
      t.text :channel_ids, array: true, default: []
      t.date :start_date
      t.date :end_date
      t.boolean :opted_distributed_plan
      t.jsonb :max_hits_allowed      
      t.boolean :auto_renewal, default: false          
      t.jsonb :exhausted
      t.jsonb :exhausted_date
      t.jsonb :hits_consumed
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end