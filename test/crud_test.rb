require "test_helper"

class TestUsers < Test::Unit::TestCase
    
    # TODO (Maynard Black): Finish Tests!!
    
    $api = Kenna::Api.new("ty9hxcpmgdrvnuqe")
    
    ################################### POST ##########################################
    
    def test_post
        @new_user = $api.post('/users', $api.fakeUser) 
        @new_user = JSON.parse(@new_user)
        $id = @new_user['body']['user']['id'] if @new_user['body']
        assert_not_nil(@new_user, "post(uri, body) Failed")
    end
    
    ################################### GET ##########################################
    
    def test_get
        @data = $api.get('/users')
        $id = @data["users"][0]['id']
        assert_not_nil(@data["users"], "get(uri) Failed")
    end
    
    ################################### PUT ##########################################
    
    def test_put
        $id = 35665
        @b = {"user":{"firstname":"Maynard"}}
        @api_response = $api.put('/users/' + $id.to_s, @b)
        assert_equal(@api_response.class, RestClient::Response, "get(uri) Failed")
    end
    
    ################################### DELETE ##########################################
    
    def test_delete
        $id = $api.getAllUsers()
        sleep(0.1) # it looks like if there are a lot of records you can't get one by index until the query is done. IDK. Need to learn more.
        $id = $id[9]['id']
        @delete = $api.delete('/users/' + $id.to_s)
        assert_equal(@delete.code, 204, "delete(uri) Failed")
    end
    
end
