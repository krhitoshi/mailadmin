require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "normal admin cannot access index" do
    sign_in_normal
    assert_raises(RuntimeError) { get admins_path }
  end

  test "super admin sees index" do
    sign_in_super
    get admins_path
    assert_response :success
    assert_match "manager@example.com", response.body
  end

  test "create normal admin with domains" do
    sign_in_super
    post admins_path, params: {
      admin: { username: "new@example.com",
               password_unencrypted: "newpass",
               password_unencrypted_confirmation: "newpass",
               active: true, form_super_admin: "0",
               domain_ids: ["example.com"] }
    }
    assert_redirected_to admins_path

    admin = Admin.find("new@example.com")
    assert_not admin.super_admin?
    assert DomainAdmin.exists?(username: "new@example.com", domain: "example.com")
  end

  test "create super admin adds ALL domain" do
    sign_in_super
    post admins_path, params: {
      admin: { username: "super2@example.com",
               password_unencrypted: "super2pass",
               password_unencrypted_confirmation: "super2pass",
               active: true, form_super_admin: "1",
               domain_ids: ["example.com"] }
    }
    assert_redirected_to admins_path

    admin = Admin.find("super2@example.com")
    assert admin.super_admin?
    assert DomainAdmin.exists?(username: "super2@example.com", domain: "ALL")
  end

  test "update admin password" do
    sign_in_super
    patch admin_path(admins(:normal)), params: {
      admin: { username: "manager@example.com",
               password_unencrypted: "changedpass",
               password_unencrypted_confirmation: "changedpass",
               active: true, form_super_admin: "0",
               domain_ids: ["example.com"] }
    }
    assert_redirected_to admins_path
    assert admins(:normal).reload.authenticate("changedpass")
  end

  test "cannot destroy self" do
    sign_in_super
    assert_raises(RuntimeError) { delete admin_path(admins(:super)) }
  end

  test "destroy another admin removes domain_admins" do
    sign_in_super
    delete admin_path(admins(:normal))
    assert_redirected_to admins_path
    assert_not Admin.exists?("manager@example.com")
    assert_not DomainAdmin.exists?(username: "manager@example.com")
  end
end
