require "test_helper"

class CalendarHelperControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get calendar_helper_new_url
    assert_response :success
  end

  test "should get create" do
    get calendar_helper_create_url
    assert_response :success
  end
end
