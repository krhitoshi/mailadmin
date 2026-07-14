require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 900] do |options|
    options.binary = '/usr/bin/chromium'
    # Use the new headless mode, which behaves like the regular browser
    options.add_argument('--headless=new')
    # Required to run Chromium inside the Docker container
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-gpu')
    options.add_argument('--disable-dev-shm-usage')
  end

  def sign_in_as(username, password)
    visit login_path
    fill_in "username", with: username
    fill_in "password", with: password
    click_button "Sign in"
  end

  def sign_in_super_ui
    sign_in_as("admin@example.com", "adminpass")
    # Wait for the Turbo form submission to finish before visiting other
    # pages, otherwise the session cookie may not be set yet
    assert_selector ".navbar-brand", text: "MailAdmin"
  end
end
