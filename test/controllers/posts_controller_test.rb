require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:new_post)
    @user = users(:login)
    @bearer_token = JsonWebToken.encode(user_id: @user.id)
  end

  test "should get index" do
    get posts_url, headers: { "AUTHORIZATION" => "Bearer #{@bearer_token}" }
    assert_response :success
  end

  test "should get index with user filter" do
    get posts_url, params: { filter: { user_id: @user.id } }, headers: { "AUTHORIZATION" => "Bearer #{@bearer_token}" }
    assert_response :success
  end

  test "should get index with pagination" do
    get posts_url, params: { page: { page: 1, items: 10 } }, headers: { "AUTHORIZATION" => "Bearer #{@bearer_token}" }
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { description: @post.description } }, as: :json,
      headers: { "AUTHORIZATION" => "Bearer #{@bearer_token}" }
    end

    assert_response 201
  end
end
