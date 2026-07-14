require 'application_system_test_case'

class MailboxDeletionsTest < ApplicationSystemTestCase
  test "delete a mailbox with confirmation dialog" do
    sign_in_super_ui
    visit domain_mailboxes_path("example.com")
    assert_text "user1@example.com"

    accept_confirm do
      click_link "Delete"
    end

    assert_no_text "user1@example.com"
    assert_not Mailbox.exists?("user1@example.com")
  end
end
