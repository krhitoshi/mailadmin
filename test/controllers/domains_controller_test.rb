require 'test_helper'

class DomainsControllerTest < ActionDispatch::IntegrationTest
  test "super admin sees all domains except ALL" do
    sign_in_super
    get domains_path
    assert_response :success
    assert_match "example.com", response.body
    assert_match "limited.example", response.body
    assert_select "td", text: "ALL", count: 0
  end

  test "normal admin sees only own domains" do
    sign_in_normal
    get domains_path
    assert_response :success
    assert_match "example.com", response.body
    assert_no_match "limited.example", response.body
  end

  test "normal admin cannot access new" do
    sign_in_normal
    assert_raises(RuntimeError) { get new_domain_path }
  end

  test "create domain" do
    sign_in_super
    post domains_path, params: {
      domain: { domain: "newdomain.example", description: "New domain",
                aliases: 5, mailboxes: 5, maxquota: 50, active: true }
    }
    assert_redirected_to domain_path("newdomain.example")
    assert Domain.exists?("newdomain.example")
    assert_equal "virtual", Domain.find("newdomain.example").transport
  end

  test "create domain with invalid name" do
    sign_in_super
    post domains_path, params: {
      domain: { domain: "invalid domain", description: "",
                aliases: 5, mailboxes: 5, maxquota: 50, active: true }
    }
    assert_response :success
    assert_not Domain.exists?("invalid domain")
  end

  test "update domain" do
    sign_in_super
    patch domain_path(domains(:example)), params: {
      domain: { description: "Changed", aliases: 20, mailboxes: 20,
                maxquota: 200, active: true }
    }
    assert_redirected_to domains_path
    domain = domains(:example).reload
    assert_equal "Changed", domain.description
    assert_equal 200, domain.maxquota
  end

  test "destroy domain removes mailboxes and aliases" do
    sign_in_super
    delete domain_path(domains(:example))
    assert_redirected_to domains_path
    assert_not Domain.exists?("example.com")
    assert_not Mailbox.exists?("user1@example.com")
    assert_not Alias.exists?("info@example.com")
  end
end
