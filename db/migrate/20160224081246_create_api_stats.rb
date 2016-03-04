class CreateApiStats < ActiveRecord::Migration
  def change
    create_table :api_stats do |t|
      t.references :group_detail, index: true
      t.references :channel_detail, index: true
      t.text :SKU_id
      t.integer :version, limit: 3
      t.inet :IP

      t.timestamps null: false
    end
  end
end
