class CreatePlanConsumptions < ActiveRecord::Migration
  def change
    create_table :plan_consumptions do |t|
      t.references :subscription_plan, index: true, foreign_key: true
      t.jsonb :plan_end_date
      t.jsonb :hits_consumed
      t.jsonb :exhausted
      t.jsonb :exhausted_date

      t.timestamps null: false
    end
  end
end
