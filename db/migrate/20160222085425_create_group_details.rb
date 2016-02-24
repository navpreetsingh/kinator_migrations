class CreateGroupDetails < ActiveRecord::Migration
  def change
    create_table :group_details do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.jsonb :header_json
      t.boolean :api_subscription

      t.timestamps null: false
    end
  end
end
