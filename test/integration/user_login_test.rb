require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cameron)
  end
  test "invalid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {
                     session: {
                      email: '',
                      password: 'foo'
                     }
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "login with remembering" do
    log_in_as(@user)
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end
end
