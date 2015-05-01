require 'test_helper'
require 'byebug'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user = users(:kucho)
  end


  test "should get sign_in" do
    sign_in @user
    assert_response :success
  end
end
