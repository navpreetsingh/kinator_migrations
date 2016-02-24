class CreatePlanConsumptions < ActiveRecord::Migration
  def change
    create_table :plan_consumptions do |t|
      t.references :plan_subscription, index: true, foreign_key: true      
      t.date :month_year
      t.integer :hits_allowed
      t.integer :hits_consumed
      t.integer :successful_hits
      t.boolean :exhausted
      t.date :exhausted_date

      t.timestamps null: false
    end
  end
end
