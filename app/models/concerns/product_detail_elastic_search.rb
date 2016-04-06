###### RUN THE BELOW COMMAND TO IMPORT DATA IN ELASTICSEARCH OR REINDEXING OF DAT  #####
# rake environment elasticsearch:import:model CLASS='Property' FORCE=y --trace

module ProductDetailElasticSearch
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    # include Elasticsearch::Model::Callbacks

    # Customize the index name
    #
    index_name "kinator_local"

    # Set up index configuration and mapping
    #
    settings index: { number_of_shards: 1, number_of_replicas: 0 } do
      mapping do        
        indexes :productName, :type => 'string'
        indexes :productCategory, :type => 'string'
        indexes :SKUId, :type => 'string'
        indexes :productBrand, :type => 'string'
        indexes :inventoryStatus, :type => 'string'
        indexes :productStatus, :type => 'string'    
        indexes :suggest, :type => 'completion', :analyzer => "simple", :search_analyzer => "simple", :payloads => true              
      end
    end

    # Set up callbacks for updating the index on model changes
    #
    after_commit lambda { Indexer.perform_async(:index,  self.class.to_s, self.id) }, on: :create
    after_commit lambda { Indexer.perform_async(:update, self.class.to_s, self.id) }, on: :update
    after_commit lambda { Indexer.perform_async(:delete, self.class.to_s, self.id) }, on: :destroy
    after_touch  lambda { Indexer.perform_async(:update, self.class.to_s, self.id) }

    def as_indexed_json(options={})          
      common_data = {        
        :productName => self.product_json["productName"],
        :productCategory => self.product_json["productCategory"].split("."),
        :SKUId => self.product_json["SKUId"],
        :productBrand => self.product_json["productBrand"],
        :inventoryStatus => self.product_json["inventoryStatus"],
        :productStatus => self.product_json["productStatus"],        
        :suggest => {
          :input => [ self.product_json["productName"].split(" "), 
                      self.product_json["productBrand"].split(" "), 
                      self.product_json["productCategory"].split(".")
                    ],
          :output => self.product_json["productName"],
          :payload => {
                        id: self.id, 
                        brand: self.product_json["productBrand"], 
                        category: self.product_json["productCategory"].split(".").last,
                        status: self.product_json["productStatus"],
                        inventory_status: self.product_json["inventoryStatus"]
                      }
        }
      }
      common_data.as_json
    end

    def self.search(hash)
      conditions = [{match: { disabled: false } }]
      # GEOLOCATION SEARCH
      if hash[:latitude].present? or hash[:longitude].present?
        conditions << {filtered: 
                        {
                          filter: {                
                            geo_distance: {
                              distance: hash[:radius].to_s + "km", 
                              location: {
                                lat: hash[:latitude],
                                lon: hash[:longitude] 
                              }                                                  
                            }                
                          }
                        }
                      }
      end
      # SELECTED ATTRIBUTES SEARCH
      conditional_array = ["property_type_id", "property_kind_id", "room", "bathroom", "status"]
      conditional_array.each do |ca|
        if hash[ca].present?
          conditions << {match: {ca => hash[ca]}}        
        end
      end
      # PRICE RANGE SEARCH
      if hash[:starting_price].present? or hash[:closing_price].present?
        hash[:starting_price] = hash[:starting_price] || 0.0
        hash[:closing_price] = hash[:closing_price] || 1000000000000000.00
        conditions << {filtered: 
                        {
                          filter: {                
                            range: {
                              price: {
                                gte: hash[:starting_price],
                                lte: hash[:closing_price] 
                              }                                                  
                            }                
                          }
                        }
                      }
      end
      # ARRAY SEARCH
      if hash[:user_property_features_list].present?
        user_property_features_list = hash[:user_property_features_list].split(",")        
        user_property_features_list.each do |list|
          conditions << {term: { user_property_features_list: list}}
        end        
      end

      @search_definition = {
        _source: hash[:lang_code],
        sort: {
          updated_at: {
            order: "desc"
          }
        },
        query: {
          bool: {                     
          }
        }
      }
      @search_definition[:query][:bool][:must] = conditions

      __elasticsearch__.search(@search_definition)       
    end

    def self.elastic_count
      __elasticsearch__.count
    end       

  end
end