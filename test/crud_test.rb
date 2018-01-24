require "test_helper"

class TestUsers < Test::Unit::TestCase
  
    $api = Kenna::Api.new("ty9hxcpmgdrvnuqe")
    
    # Create
    def test_post
        @new_user = $api.post('/users', $api.fakeUser)
        $id = @new_user["user"]["id"]
        assert_not_nil(@new_user, "post(uri, body) Failed")
    end
    
    def test_post_by_resource
        @new_user2 = $api.postByResource('users', $api.fakeUser)
        @id2 = @new_user2["user"]["id"]
        assert_not_nil(@new_user2, "post(resource, body) Failed")
    end
    
    # Read
    def test_get_from_uri
        @data = $api.get('/users')
        assert_not_nil(@data, "get(uri) Failed")
    end
    
    def test_get_a_single_resource_by_id
        @data = $api.getById('users', $id)
        assert_not_nil(@data["user"]["id"], "getById(resource, id) Failed")
    end
    
    # TODO (Maynard Black): Update Tests

    # Delete
    def test_delete_by_uri
        @data = $api.delete('/users/' + $id)
        assert_equal(@data.code, 200, "delete(uri) Failed")
    end
    
    def test_delete_by_id
        @data = $api.deleteById('users', $id2)
        assert_equal(@data.code, 200, "deleteById(resource, id) Failed")
    end

end
