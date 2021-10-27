require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Cameron T', email: 'cameron@gmail.com',
                      password: 'foobar', password_confirmation: 'foobar')
  end

  test "valid user" do
    assert @user.valid?
  end

  test "email validations" do
    @user.email = ''
    assert_not @user.valid?
    @user.email = 'a'*300
    assert_not @user.valid?
    @user.email = 'foo@fo1com'
    assert_not @user.valid?
  end

  test "password validations" do
    @user.password = 'aa'
    assert_not @user.valid?
  end
end
