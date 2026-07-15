require 'test_helper'

class MailboxTest < ActiveSupport::TestCase
  test "password round trip (DovecotCramMd5Password)" do
    mailbox = mailboxes(:user1)
    assert_equal mailbox, mailbox.authenticate("user1pass")
    assert_equal false, mailbox.authenticate("wrongpass")
  end

  test "before_validation builds username maildir quota and alias" do
    mailbox = Mailbox.new(local_part: "user2", name: "User Two",
                          password_unencrypted: "user2pass",
                          password_unencrypted_confirmation: "user2pass",
                          quota_mb: 50)
    mailbox.rel_domain = domains(:example)

    assert mailbox.valid?
    assert_equal "user2@example.com", mailbox.username
    assert_equal "example.com/user2@example.com/", mailbox.maildir
    assert_equal 50 * 1_024_000, mailbox.quota
    assert_equal "user2@example.com", mailbox.alias.address
  end
end
