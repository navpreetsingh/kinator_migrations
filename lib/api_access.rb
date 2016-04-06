require 'rest_client'
class ApiAccess
	#change local to 'developer' for port 3009, and to 'qa_testing' for port 3011
	@@url = "http://localhost:7890/api/v1/"
	err_response = Hashie::Mash.new({error_code: 400})
	class << self
		
		#  ApiAccess.get("employees.json") will get all the details of employees
		def get(link, params = nil)						
			uri = URI(@@url + link + (params.nil? ? "" : "?" + params.to_query))		
	    response = Net::HTTP.get_response(uri)
	    data = parse_data(response.body)
	    rescue Exception => e
			err_response = Hashie::Mash.new({error_code: 400, exception: e})				
		end

		def parse_data(response)												
			response = JSON.parse(response)				
			if response.class == Hash
				Hashie::Mash.new(response)
			else
	    	data = Hashie::Mash.new(:response => response)	    
	    	data.response
	    end
	    rescue Exception => e
			err_response = Hashie::Mash.new({error_code: 400, exception: e})				
		end	
	end
end