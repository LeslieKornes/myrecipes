require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest

  test "should reject invalid login" do
    get login_path
    assert_template 'sessions/new'
  end

  test "should accept valid login credentials and log user in" do
    get login_path
    assert_template 'sessions/new'
  end

end
