require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should not be accessible" do
    get "/unknown"
    assert_response 404
  end
end
