require 'test_helper'

class DaysControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get days_show_url
    assert_response :success
  end

end
