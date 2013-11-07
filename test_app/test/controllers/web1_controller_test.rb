require 'test_helper'

class Web1ControllerTest < ActionController::TestCase
  test "should get hello" do
    get :hello
    assert_response :success
  end

  test "should get world" do
    get :world
    assert_response :success
  end

end
