require 'application_system_test_case'

class NavbarTest < ApplicationSystemTestCase
  test "user menu dropdown opens and signs out" do
    sign_in_super_ui

    # menu items are hidden until the dropdown is opened
    # (Sign out is a button_to form since the Hotwire migration)
    assert_no_button "Sign out"
    click_button "admin@example.com"
    assert_link "Profile"

    click_button "Sign out"
    assert_text "Please sign in"
  end
end
