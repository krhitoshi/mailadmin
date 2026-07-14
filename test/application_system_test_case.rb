require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 900] do |options|
    options.binary = '/usr/bin/chromium'
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
  end
end
