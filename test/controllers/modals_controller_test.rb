require "test_helper"

class ModalsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get modals_show_url
    assert_response :success
  end

  test "should get destroy" do
    get modals_destroy_url
    assert_response :success
  end
end
