require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:plan)
  end

test "redirect when not logged in " do
  assert_no_difference 'Micropost.count' do
    post microposts_path, params: {
                          micropost: {
                            content: 'Lorem ipsum'
                          }
    }
  end
  assert_redirected_to login_url
end

test "redirect destroy when not logged in" do
  assert_no_difference 'Micropost.count' do
    delete micropost_path(@micropost)
  end
  assert_redirected_to login_url
  end
end
