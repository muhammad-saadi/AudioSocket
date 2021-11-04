require "test_helper"

class AuditionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get auditions_index_url
    assert_response :success
  end
end
