class CreatePlanConsumptions < ActiveRecord::Migration
  def change
    create_table :plan_consumptions do |t|
      t.references :subscription_plan, index: true, foreign_key: true
      t.datetime :plan_end_date
      t.integer :hits_consumed
      t.boolean :exhausted
      t.datetime :exhausted_date

      t.timestamps null: false
    end
  end
end
