require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get basic" do
    get settings_basic_url
    assert_response :success
  end

end
