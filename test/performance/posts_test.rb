require 'test_helper'
require 'rails/performance_test_help'

ActiveSupport::Deprecation.behavior = :silence

class PostsIndexTest < ActionDispatch::PerformanceTest
  self.profile_options = { :runs => 100,
                           :metrics => [:wall_time] }
  
  def setup
    log_in_as(users(:user))
  end
  
  test "displaying posts index" do
    get '/posts'
  end
  
  test "displaying post page" do
    get post_path(posts(:post_1))
  end
end
