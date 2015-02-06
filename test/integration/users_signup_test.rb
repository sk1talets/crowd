require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
  end
  
  test "successful signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: {name: "username",
                              password: "password",
                              password_confirmqtion: "password"}
    end
    assert_redirected_to(controller: "posts", action: "index")
  end
  
  test "invalid signup information" do
    assert_no_difference 'User.count' do
        get signup_path
        post users_path, user: {name: "x!x",
                                password: "xxx",
                                password_confirmation: "zzz"}
    end
    assert_template 'users/new'
        
    assert_select "ul>li", { :text => "Name is too short (minimum is 4 characters)", :count => 1 }
    assert_select "ul>li", { :text => "Name is invalid", :count => 1 }
    assert_select "ul>li", { :text => "Password confirmation doesn't match Password", :count => 1 }
    assert_select "ul>li", { :text => "Password is too short (minimum is 6 characters)", :count => 1}
  end
end
