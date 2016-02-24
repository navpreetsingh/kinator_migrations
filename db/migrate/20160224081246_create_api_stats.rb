class CreateApiStats < ActiveRecord::Migration
  def change
    create_table :api_stats do |t|
      t.references :group_detail, index: true, foreign_key: true
      t.references :channel_detail, index: true, foreign_key: true
      t.bigint :SKU_id
      t.integer :version, limit: 3
      t.inet :IP

      t.timestamps null: false
    end
  end
end
