class ProductDetail < ActiveRecord::Base
  self.table_name = "product_detail"
  include ProductDetailElasticSearch
end
