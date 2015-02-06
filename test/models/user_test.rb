require 'test_helper'

class UserTest < ActiveSupport::TestCase
PASSWORD = "q!w@e#"

  def setup
    @user = users(:user) 
    @admin = users(:admin) 
  end

  test "user is valid" do
    assert @user.valid?
  end
  
  test "user with empty name is not valid" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  test "user with empty string as a name is not valid" do
    @user.name = "    "
    assert_not @user.valid?
  end
  
  test "user with name shorter than 4 symbols is not valid" do
    @user.name = "abc"
    assert_not @user.valid?
  end
  
  test "user with name longer than 20 symbols is not valid" do
    assert @user.valid?
    @user.name = "a" * 21
    assert_not @user.valid?
  end
  
  test "user with name containing national characters is not valid" do
    @user.name = "тест"
    assert_not @user.valid?
  end
  
  test "user with name containing special characters is not valid" do
    @user.name = "test #dsd test"
    assert_not @user.valid?
  end
  
  test "users with duplicate namea are not allowed" do
    user_ = @user.dup
    @user.save
    assert_not user_.valid?
  end

  test "check user roles" do
    assert_not @user.admin?
    assert @admin.admin?
  end
  
  test "check user default role" do
    user_= users(:user) 
    assert user_.user?
  end

  test "check user with password shorter than 6 symbols is not valid" do
    @user.password = @user.password_confirmation = "x" * 6
    assert @user.valid?
    @user.password = @user.password_confirmation = "x" * 5
    assert_not @user.valid?
  end
  
  test "check authentication" do
    assert_not @user.authenticate("wrongpassword")
    assert @user.authenticate(PASSWORD)
  end
  
end
