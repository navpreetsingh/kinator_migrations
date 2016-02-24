class CreatePlanSubscriptions < ActiveRecord::Migration
  def change
    create_table :plan_subscriptions do |t|
      t.references :group_detail, index: true, foreign_key: true
      t.references :api_subscription_plan, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
    add_index :plan_subscriptions, [:group_detail_id, :api_subscription_plan_id], unique: true, name: "plan_subscription"
  end
end
