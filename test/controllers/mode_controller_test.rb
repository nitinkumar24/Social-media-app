require 'test_helper'

class ModeControllerTest < ActionDispatch::IntegrationTest
  test "should get select" do
    get mode_select_url
    assert_response :success
  end

end
