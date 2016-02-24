class CreateGroupDetails < ActiveRecord::Migration
  def change
    create_table :group_details do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.jsonb :header_json
      t.string :user_id
      t.string :secret_key
      t.text :authorized_urls, array: true, default: []
      t.string :email

      t.timestamps null: false
    end
  end
end
