# Author:: Maynard Black.
# Email:: maynardblack@hotmail.com
# Copyright:: Copyright (c) 2018 Maynard Black. All rights reserved.
# License:: Ruby license.

require 'json'
require 'kenna/version'
require 'rest-client'
require 'faker'

module Kenna
  class Api
    
    # Must have a token to continue
    def initialize(token)
      $token = token
      
      # Slow it down 500ms due to throttling
      sleep(0.5)
    end
    
    # TODO (Maynard Black): ask Kenna about API versioning
    $base_url = "https://api.kennasecurity.com"
    
    # Here are some generic CRUD calls to the API
    # The URI is the full resource path without the base URL
    # 'Resource' would be the same as base_key or root of the endpoint
    # TODO (Maynard Black): Confirm with Kenna if this is standard and can be depended upon
    # TODO (Maynard Black): Use config to set base URL and Token, find out how Kenna plans to version the API
    # TODO (Maynard Black): Ask Kenna if ID's are unique accross all endpoints and do they plan on offering
    #       an endpoint to locate any resource by just the ID (they are not UUIDs so not likely)
    # TODO (Important - Maynard Black): Refactor to return the whole response including headers
    #        This means updating the tests first! Then the API Browser App!
    #        I am currently only returning a JSON parsed body so there is no way to catch 404s and such
    #        UPDATE: DONE
    # TODO (Maynard Black): Refactor the 2 post, put, getAllUsers, getUserById methods to return headers
    # TODO (Maynard Black): Catch exceptions when hitting server, that is the only way to 
    #       catch certain response codes (like 404) with the client I am using
    
    #################### Post #################### 
    
    def post(uri, body)
      body = body.to_json
      @url = $base_url + uri
      @response = RestClient.post(@url, body, headers={'X-Risk-Token' => $token, 'Content-Type' => 'application/json', 'Accept' => 'application/json'})
      
    rescue StandardError => e 
      @return = {}
      #@return['body'] = nil
      @return['http_code'] = e.http_code
      @return['message'] = e.message
      @return.to_json
    #ensure
    end
    
    
    #################### Get ####################
    def get(uri)
      @url = $base_url + uri
      @response = RestClient.get(@url, headers={'X-Risk-Token' => $token, 'Content-Type' => 'application/json', 'Accept' => 'application/json'})
    end
    
    #################### Put ####################
    def put(uri, body)
      body = body.to_json
      @url = $base_url + uri
      @response = RestClient.put(@url, body, headers={'X-Risk-Token' => $token, 'Content-Type' => 'application/json', 'Accept' => 'application/json'})
      
    rescue StandardError => e 
      @return = {}
      @return['http_code'] = e.http_code
      @return['message'] = e.message
      @return.to_json
    #ensure
    end
    

    #################### Delete ####################
    def delete(uri)
      @url = $base_url + uri
      @response = RestClient.delete(@url, headers={'X-Risk-Token' => $token, 'Content-Type' => 'application/json', 'Accept' => 'application/json'})
    end
    

    #################### User Specific Methods ####################
    
    # TODO (Maynard Black): Finish all User options
    # TODO (Maynard Black): Do this for all other endpoints
    # TODO (Maynard Black): Some endpoint calls will require an array of id's, the app can fill
    #       in the rest
    
    def getAllUsers()
      @url = $base_url + '/users'
      @response = RestClient.get(@url, headers={'X-Risk-Token' => $token, 'Content-Type' => 'application/json', 'Accept' => 'application/json'})
      JSON.parse(@response.body)["users"]
    end
    
    def getUserById(id)
      @url = $base_url + '/users/' + id.to_s
      @response = RestClient.get(@url, headers={'X-Risk-Token' => $token, 'Content-Type' => 'application/json', 'Accept' => 'application/json'})
      JSON.parse(@response.body)["user"]
    end
    
    #################### Generate a unique fake user for testing ####################
    
    def fakeUser
      @roles = ['administrator', 'normal user', 'Linux Test Environment']
      @role = @roles[rand(0..2)]
      @fake_user = {
                      "user":
                        {
                          "firstname": Faker::Name.first_name,
                          "lastname": Faker::Name.last_name,
                          "email": Faker::Internet.email,
                          "role": @role
                        }
                    }
    end
      
    #################### Pretty version for API Browser ####################
    def fakeUserPretty
      @fup = JSON.pretty_generate JSON.parse(fakeUser)
      @fup.to_s
    end
    
    ########################################################################
  end
end

# BASIC MANUAL TESTS 
# There are actual tests (in /test - run 'rake') for some things (Written first believe it or not!)
# But I wrote these local test to get a better idea of what was happening 
# TODO (Maynard Black): Finish tests!
# TODO (Maynard Black): The sample account Token will need to change! This is my free temp one
# TODO (Maynard Black): Address throttling issues


$api = Kenna::Api.new("ty9hxcpmgdrvnuqe")

################################### POST ##########################################

# @b = {"user":{"firstname":"Izabella","lastname":"Lowe","email":"cristobal.rutherford@fadelanderson.biz","phone":"(488) 202-7225","role":"normal user"}}
# puts @b
# puts $api.fakeUser
# @new_user = $api.post('/users', @b)

# @new_user = JSON.parse(@new_user);
# $id = @new_user["user"]["id"]
# puts $id

# @new_user = $api.post('/users', $api.fakeUser) 
# @new_user = JSON.parse(@new_user)
# if @new_user['message']
#   puts '*ERROR* *ERROR* *ERROR* *ERROR* *ERROR* *ERROR* '
#   puts @new_user
# else
#   puts @new_user['user']['id']
# end

# @new_user = $api.postByResource('users', $api.fakeUser)
# $id2 = @new_user["user"]["id"]
# puts $id2

################################### GET ########################################

# @users = $api.getAllUsers()
# puts @users

# @new_user = $api.get('/users/' + $id.to_s)
# @new_name = @new_user["user"]["firstname"]
# puts @new_user
# puts @new_name

# @data = $api.getById('users', 35665)
# puts @data.class

# @data = $api.getById('users', 35665)
# @data = JSON.parse(@data.body)
# puts @data['user']['id']

################################### PUT ########################################

# $id = 35665
# @b = {"user":{"firstname":"Maynard"}}
# @api_response = $api.put('/users/' + $id.to_s, @b)

# if @api_response.class != RestClient::Response
#   puts @api_response
# else
#   @get_api_response = $api.get('/users/' + $id.to_s)
#   puts @get_api_response
# end

 
# @body = {"firstname":"KERMIT"}
# $api.put('/users/' + $id.to_s, @body)


################################### DELETE #####################################

# $id = $api.getAllUsers()
# sleep(0.1) # it looks like if there are a lot of records you can't get one by index until the query is done. IDK. Need to learn more.
# $id = $id[9]['id']

# @delete = $api.delete('/users/' + $id.to_s)
# puts @delete.code

# $id = 35940
# @user = $api.get('/users/' + $id.to_s)
# puts @user
################################### Custom - /user #############################

# @users = JSON.parse(@users)
# puts @users[@users.keys[0]]
 
# @user_id = @users[0]['id']
# @user = $api.getUserById(@user_id)
# puts @user['id'] == 35665