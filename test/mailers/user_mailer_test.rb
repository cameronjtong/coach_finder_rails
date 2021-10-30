require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = User.first
    @user.activation_token = User.new_token
  end
  test "account_activation" do
    mail = UserMailer.account_activation(@user)
    assert_equal "Account activation", mail.subject
    assert_equal [@user.email], mail.to
  end

  test "password_reset" do
    user = users(:cameron)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_match CGI.escape(user.email), mail.body.encoded
  end

end
