# Author:: Maynard Black.
# Email:: maynardblack@hotmail.com
# Copyright:: Copyright (c) 2018 Maynard Black. All rights reserved.
# License:: Ruby license.

class Api
    
    def initialize(token)
      @token = token
    end
    
    def getAllUsers()
      callApi('GET', '/users', 'users', {})
    end
    
    def callApi(meth, endpoint, base_key, body)
        require 'net/https'
        require 'uri'
        require 'json'
        
        url = URI.parse("https://api.kennasecurity.com")
        #base_url = 'https://api.kennasecurity.com'
        #params = ''
        #url = base_url + endpoint + params;
        data = nil
        
        http = Net::HTTP.new(url.host, 443)
        http.use_ssl = true
        http.start do |http|
          request  =
            Net::HTTP::Get.new(endpoint, {'X-Risk-Token' => @token, 'ContentType' => 'application/json', 'Accept' => 'application/json'})
          response = http.request(request)
          #data_str = JSON.pretty_generate JSON.parse(response.body)[base_key]
          data = JSON.parse(response.body)[base_key]
        end
        data
    end
end

#@api = Api.new("ty9hxcpmgdrvnuqe")
#d = @api.getAllUsers()
#puts d
