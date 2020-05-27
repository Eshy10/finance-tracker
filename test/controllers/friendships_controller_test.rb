require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get friend_list" do
    get friendships_friend_list_url
    assert_response :success
  end

end
