require "test_helper"

class TestUsers < Test::Unit::TestCase
  
  $api = Kenna::Api.new("ty9hxcpmgdrvnuqe")
  $users = $api.getAllUsers()
  
  def test_get_all_users
    assert_not_equal(0, $users.length, "No Users, there should be at least one.")
  end
  
  def test_get_user_by_id
    @user_id = $users[0]['id']
    @user = $api.getUserById(@user_id)
    assert_equal(@user['id'], @user_id, "Failed to get user by ID")
  end
  
end
