require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login page" do
    get login_path
    assert_response :success
  end

  test "login with valid credentials" do
    sign_in_super
    assert_redirected_to root_url

    get domains_path
    assert_response :success
  end

  test "login with wrong password" do
    sign_in("admin@example.com", "wrongpass")
    assert_redirected_to login_path
    assert_equal "Incorrect username or password.", flash[:alert]
  end

  test "login with inactive admin" do
    sign_in("inactive@example.com", "inactivepass")
    assert_redirected_to login_path
  end

  test "unauthenticated access redirects to login" do
    get domains_path
    assert_redirected_to login_url
  end

  test "logout" do
    sign_in_super
    delete logout_path
    assert_redirected_to login_path

    get domains_path
    assert_redirected_to login_url
  end
end
