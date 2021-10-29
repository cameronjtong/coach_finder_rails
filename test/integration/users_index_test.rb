require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:cameron)
    @non_admin = users(:nick)
  end

  test "index as admin including links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      unless user == @admin
      assert_select 'a[href=?]', user_path(user), text: 'Delete user'
    end
  end
  end
end
