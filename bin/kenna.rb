# Author:: Maynard Black.
# Email:: maynardblack@hotmail.com
# Copyright:: Copyright (c) 2018 Maynard Black. All rights reserved.
# License:: Ruby license.

require "kenna/version"

module Kenna
    class Api
    
        def initialize(token)
          @token = token
        end
        
        def getAllUsers()
          callApi('GET', '/users', 'users', {})
        end
        
        def getUserById(id)
          path = '/users/' + id.to_s
          callApi('GET', path, 'user', {})
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
            data_str = nil
            
            http = Net::HTTP.new(url.host, 443)
            http.use_ssl = true
            http.start do |http|
              request  =
                Net::HTTP::Get.new(endpoint, {'X-Risk-Token' => @token, 'Content-Type' => 'application/json', 'Accept' => 'application/json'})
              response = http.request(request)
              #data_str = JSON.pretty_generate JSON.parse(response.body)[base_key]
              if base_key
                  data = JSON.parse(response.body)[base_key]
              else
                  data = JSON.parse(response.body)
              end
            end
            data
        end
    end
end

@api = Kenna::Api.new("ty9hxcpmgdrvnuqe")
@users = @api.getAllUsers()
@user_id = @users[0]['id']
@user = @api.getUserById(@user_id)

#puts @user['id'] == 35665

