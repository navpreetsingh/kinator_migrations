class CreateChannelDetails < ActiveRecord::Migration
  def change
    create_table :channel_details do |t|
      t.string :channel_name, length: 200
      t.string :channel_data_field,  length: 150
      t.text :channel_unique_key
      t.string :channel_code
      t.boolean :has_product_id
      t.boolean :has_city
      t.text :icon
      t.string :business_model, length: 30

      # t.timestamps null: false
    end
  end
end
