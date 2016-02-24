class CreateGroupAuthenticationDetails < ActiveRecord::Migration
  def change
    create_table :group_authentication_details do |t|
      t.string :user_id
      t.string :secret_key
      t.text :authorized_urls, array: true, default: []
      t.references :group_detail, index: true, foreign_key: true
      t.string :email
      # t.jsonb :subsciption_plan
      # t.jsonb :subscription_history

      t.timestamps null: false
    end
  end
end
