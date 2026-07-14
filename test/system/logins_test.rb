require 'application_system_test_case'

class LoginsTest < ApplicationSystemTestCase
  test "login and see domains" do
    sign_in_super_ui
    assert_selector "td", text: "example.com"
  end

  test "login with wrong password shows alert" do
    sign_in_as("admin@example.com", "wrongpass")
    assert_text "Incorrect username or password."
  end
end
