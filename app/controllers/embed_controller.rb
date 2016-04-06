class EmbedController < ApplicationController
  def show
  	if params[:table_name].present?
  		table_name = params[:table_name].singularize.constantize
  		columns = table_name.columns.map {|c| c.name + ", " + c.sql_type.upcase }
  		data = params[:table_name].singularize.constantize.all
  		count = data.count
  		json_data = JSON.pretty_generate({columns: columns, count: count, data: data.nil? ? nil : JSON.parse(data.to_json)})
  		render :json => json_data
  	end
  end
end
