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
    
    #def test_post_by_resource
    #    @new_user2 = $api.postByResource('users', $api.fakeUser)
    #    @id2 = @new_user2["user"]["id"]
    #    assert_not_nil(@new_user2, "post(resource, body) Failed")
    #end
    
    ################################### GET ##########################################
    
    def test_get_from_uri
        @data = $api.get('/users')
        $id = @data["users"][0]['id']
        assert_not_nil(@data["users"], "get(uri) Failed")
    end
    
    def test_get_a_single_resource_by_id
        @data = $api.getById('users', 35665)
        @data = JSON.parse(@data.body)
        assert_equal(35665, @data['user']['id'], "getById(resource, id) Failed")
    end
    
    ################################### PUT ##########################################
    
    
    ################################### DELETE ##########################################
    
    #def test_delete_by_uri
    #    @data = $api.delete('/users/' + $id)
    #    assert_equal(@data.code, 200, "delete(uri) Failed")
    #end
    
    #def test_delete_by_id
    #    @data = $api.deleteById('users', $id2)
    #    assert_equal(@data.code, 200, "deleteById(resource, id) Failed")
    #end

end
