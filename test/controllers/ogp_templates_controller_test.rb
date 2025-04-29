require "test_helper"

class OgpTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get ogp_templates_show_url
    assert_response :success
  end
end
