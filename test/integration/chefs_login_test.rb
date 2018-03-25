require 'test_helper'

class ChefsLoginTest < ActionDispatch::IntegrationTest

  test "should reject invalid login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: " ", password: " " } }
    assert_template 'sessios/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "should accept valid login credentials and log user in" do
    get login_path
    assert_template 'sessions/new'
  end

end
