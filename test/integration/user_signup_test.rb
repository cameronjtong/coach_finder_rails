require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

   test "valid signup" do
    get signup_path
    post users_path,
         params: {
           user: {
             name: "Cameron",
             email: "cameron.tong2b@gmail.com",
             password: "foobar",
             password_confirmation: "foobar",
           },
         }
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test "invalid signup" do
    get signup_path
    post users_path,
         params: {
           user: {
             name: "Cameron",
             email: "cameron.tong2b@gmail",
             password: "foo",
             password_confirmation: "foo",
           },
         }
    assert_template "users/new"
  end

  test "valid signup with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
                       user: {
                        name: 'Cameron',
                        email: 'example@railstutorial.com',
                        password: 'foobar',
                        password_confirmation: 'foobar'
                       }
      }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert_template 'account_activations/edit'
  end
end
