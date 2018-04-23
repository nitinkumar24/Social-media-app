require 'test_helper'

class UserBlockControllerTest < ActionDispatch::IntegrationTest
  test "should get blockkarnahai" do
    get user_block_blockkarnahai_url
    assert_response :success
  end

end
