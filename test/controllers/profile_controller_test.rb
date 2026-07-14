require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "edit page" do
    sign_in_super
    get profile_path
    assert_response :success
  end

  test "update password and login again" do
    sign_in_super
    patch profile_path, params: {
      admin: { password_unencrypted: "newadminpass",
               password_unencrypted_confirmation: "newadminpass" }
    }
    assert_redirected_to profile_path
    assert_equal "Your password was successfully updated.", flash[:notice]

    delete logout_path
    sign_in("admin@example.com", "newadminpass")
    assert_redirected_to root_url
  end

  test "blank password is rejected and old password remains" do
    sign_in_super
    patch profile_path, params: {
      admin: { password_unencrypted: "",
               password_unencrypted_confirmation: "" }
    }
    assert_response :unprocessable_entity
    assert_nil flash[:notice]
    assert admins(:super).reload.authenticate("adminpass")
  end
end
