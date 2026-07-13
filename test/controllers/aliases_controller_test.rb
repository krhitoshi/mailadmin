require 'test_helper'

class AliasesControllerTest < ActionDispatch::IntegrationTest
  test "index shows pure aliases" do
    sign_in_super
    get domain_aliases_path(domains(:example))
    assert_response :success
    assert_match "info@example.com", response.body
  end

  test "create alias joins forward addresses into goto" do
    sign_in_super
    post domain_aliases_path(domains(:example)), params: {
      alias: { local_part: "sales", active: true,
               forward_addresses: ["a@example.org", "b@example.org", ""] }
    }
    assert_redirected_to domain_aliases_path("example.com")
    assert_equal "a@example.org,b@example.org", Alias.find("sales@example.com").goto
  end

  test "create alias fails when domain alias limit is reached" do
    sign_in_super
    post domain_aliases_path(domains(:limited)), params: {
      alias: { local_part: "second", active: true,
               forward_addresses: ["x@example.org"] }
    }
    assert_response :success
    assert_not Alias.exists?("second@limited.example")
  end

  test "update alias" do
    sign_in_super
    patch domain_alias_path(domains(:example), aliases(:info)), params: {
      alias: { local_part: "info", active: true,
               forward_addresses: ["changed@example.org", ""] }
    }
    assert_redirected_to domain_aliases_path("example.com")
    assert_equal "changed@example.org", aliases(:info).reload.goto
  end

  test "destroy alias" do
    sign_in_super
    delete domain_alias_path(domains(:example), aliases(:info))
    assert_redirected_to domain_aliases_path("example.com")
    assert_not Alias.exists?("info@example.com")
  end

  test "cannot access alias through another domain" do
    sign_in_super
    assert_raises(RuntimeError) do
      get edit_domain_alias_path(domains(:example), aliases(:limited_info))
    end
  end
end
