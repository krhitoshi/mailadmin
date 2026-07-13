require 'test_helper'

class MailboxesControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    sign_in_super
    get domain_mailboxes_path(domains(:example))
    assert_response :success
    assert_match "user1@example.com", response.body
  end

  test "create mailbox also creates accompanying alias" do
    sign_in_super
    post domain_mailboxes_path(domains(:example)), params: {
      mailbox: { local_part: "user2", name: "User Two",
                 password_unencrypted: "user2pass",
                 password_unencrypted_confirmation: "user2pass",
                 quota_mb: 50, active: true }
    }
    assert_redirected_to domain_path("example.com")

    mailbox = Mailbox.find("user2@example.com")
    assert_equal 50 * 1_024_000, mailbox.quota
    assert_equal "example.com/user2@example.com/", mailbox.maildir

    assert Alias.exists?("user2@example.com")
    assert_equal "user2@example.com", Alias.find("user2@example.com").goto
  end

  test "create mailbox fails when quota exceeds domain maxquota" do
    sign_in_super
    post domain_mailboxes_path(domains(:example)), params: {
      mailbox: { local_part: "user2", name: "User Two",
                 password_unencrypted: "user2pass",
                 password_unencrypted_confirmation: "user2pass",
                 quota_mb: 200, active: true }
    }
    assert_response :success
    assert_not Mailbox.exists?("user2@example.com")
  end

  test "update mailbox" do
    sign_in_super
    patch domain_mailbox_path(domains(:example), mailboxes(:user1)), params: {
      mailbox: { local_part: "user1", name: "Renamed", quota_mb: 60, active: true }
    }
    assert_redirected_to domain_path("example.com")

    mailbox = mailboxes(:user1).reload
    assert_equal "Renamed", mailbox.name
    assert_equal 60 * 1_024_000, mailbox.quota
  end

  test "destroy mailbox removes alias and quota usage" do
    sign_in_super
    Quota.create!(username: "user1@example.com", bytes: 1000, messages: 1)

    delete domain_mailbox_path(domains(:example), mailboxes(:user1))
    assert_redirected_to domain_path("example.com")
    assert_not Mailbox.exists?("user1@example.com")
    assert_not Alias.exists?("user1@example.com")
    assert_not Quota.exists?("user1@example.com")
  end
end
