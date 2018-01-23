require "test_helper"

class TestKenna < Test::Unit::TestCase

  def test_api
    @api = Kenna::Api.new("ty9hxcpmgdrvnuqe")
    assert_not_nil(@api, "Api not instantiated.")
  end
  
end
