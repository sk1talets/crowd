require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "geting posts index" do
    get :index
    assert_response :success
    assert_select "div.post", { :count => 3 }
  end
  
  test "posts show should redirect to login page if not logged in" do
    get :show, id: posts(:post_1).id
    assert_redirected_to login_path
  end
  
  test "posts show should display the post" do
    log_in_as(users(:user))
    get :show, id: posts(:post_1).id
    assert_response :success
  end
end
