class ElasticSearchController < ApplicationController
  
  def suggestion  	
  	@data = ApiAccess.get("products/auto_suggestion", {:desc => params[:ip]})
    @data = @data["search-result"]
  	respond_to do |format|
      format.js
    end
  end

  def search
  	if request.xhr?
      hash = {"products" => "productName", "brands" => "productBrand", "categories" => "productCategory", "status" => "productStatus", "inventory_status" => "inventoryStatus"}
      parameters = {"productName" => [], "productBrand" => [], "productCategory" => [], "productStatus" => [], "inventoryStatus" => [], "search_tags" => "" }
      search_params = params[:suggestion][:search_params].compact.reject(&:blank?)
      search_params.each do |p|
        p = p.split(".")        
        parameters[hash[p.first]] << p.last
      end
      parameters["search_tags"] = params[:suggestion][:search_tags] unless params[:suggestion][:search_tags].nil? 
      # debugger;
      @data = ApiAccess.get("products", parameters)            
  	else
  		@data = ApiAccess.get("products")      
  	end
    debugger
  	respond_to do |format|
			request.xhr? ? format.js : format.html			
		end
  end
end
