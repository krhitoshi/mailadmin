require 'application_system_test_case'

# The alias edit form is the only custom JS in the app
# (dynamic add/remove of forward address rows)
class AliasForwardAddressesTest < ApplicationSystemTestCase
  FORWARD_INPUTS = 'input[name="alias[forward_addresses][]"]'.freeze

  test "add a forward address" do
    sign_in_super_ui
    visit edit_domain_alias_path("example.com", "info@example.com")

    # existing goto + one trailing empty row
    assert_selector FORWARD_INPUTS, count: 2

    click_button "Add"
    assert_selector FORWARD_INPUTS, count: 3

    all(FORWARD_INPUTS).last.set("added@example.org")
    click_button "Update Alias"

    assert_text "Alias was successfully updated."
    assert_equal "external@example.org,added@example.org",
                 Alias.find("info@example.com").goto
  end

  test "remove a forward address row" do
    sign_in_super_ui
    visit edit_domain_alias_path("example.com", "info@example.com")

    click_button "Add"
    assert_selector FORWARD_INPUTS, count: 3

    all(".delete-forward-address-button").last.click
    assert_selector FORWARD_INPUTS, count: 2
  end
end
