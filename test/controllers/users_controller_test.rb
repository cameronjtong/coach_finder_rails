require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cameron)
    @other_user = users(:nick)
  end
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
    end

test "redirect destroy when non admin" do
  log_in_as(@other_user)
  assert_no_difference 'User.count' do
  delete user_path(@user)
end
assert_redirected_to root_url
end
  end
