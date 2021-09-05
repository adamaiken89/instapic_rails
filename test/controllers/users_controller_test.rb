require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { name: "new_user", password: "123456" } }, as: :json
    end

    assert_response 201
  end

  test "should not create user" do
    @user = users(:login)
    post users_url, params: { user: { name: @user.name, password: "123456" } }, as: :json

    assert_response 422
  end
end
