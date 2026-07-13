ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def sign_in(username, password)
    post login_path, params: { username: username, password: password }
  end

  # fixture の super admin でログインする
  def sign_in_super
    sign_in("admin@example.com", "adminpass")
  end

  # fixture の一般 admin でログインする
  def sign_in_normal
    sign_in("manager@example.com", "managerpass")
  end
end
