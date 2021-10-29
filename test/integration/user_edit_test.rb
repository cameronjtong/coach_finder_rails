require "test_helper"

class UserEditTest < ActionDispatch::IntegrationTest
 def setup
  @user = users(:cameron)
 end

 test "unsuccessful edit" do
  log_in_as(@user)
  get edit_user_path(@user)
  assert_template 'users/edit'
  patch user_path(@user), params: {
                          user: {
                            name: "",
                            email: "foo@invalid",
                            password: 'foo',
                            password_confirmation: 'foo'
                          }
  }
  assert_template 'users/edit'
 end

 test "successful edit" do
  log_in_as(@user)
  get edit_user_path(@user)
  assert_template 'users/edit'
  patch user_path(@user), params: {
                          user: {
                            name: "Adrian C",
                            email: "foo@valid.com",
                            password: 'foobar',
                            password_confirmation: 'foobar'
                          }
  }
  assert_not flash.empty?
  assert_redirected_to @user
 end

 test "edit with forwarding" do
  get edit_user_path(@user)
  log_in_as(@user)
  assert_redirected_to edit_user_path(@user)
  name = 'Foo bar'
  email = 'foo@valid.com'
  patch user_path(@user), params: {
                          user: {
                            name: name,
                            email: email,
                            password: '',
                            password_confirmation: ''
                          }
  }
  assert_not flash.empty?
 end
end
