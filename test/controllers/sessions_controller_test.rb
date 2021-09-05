require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:login)
  end

  test "should fail if the name does not exist" do
    post sessions_url, params: { user: { name: "No Name" } }, as: :json
    assert_response 401
  end

  test "should fail with an incorrect password" do
    post sessions_url, params: { user: { name: @user.name, password: "WRONG" } }, as: :json
    assert_response 401
  end

  test "should create session" do
    post sessions_url, params: { user: { name: @user.name, password: "123456" } }, as: :json
    assert_response 201
  end
end
