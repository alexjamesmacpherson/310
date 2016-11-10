require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_home_url
    assert_response :success
  end

  test "should get about" do
    get static_about_url
    assert_response :success
  end

  test "should get login" do
    get static_login_url
    assert_response :success
  end

  test "should get signup" do
    get static_signup_url
    assert_response :success
  end

end
