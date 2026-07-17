source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Rails 7.1 requires Ruby 2.7.0 or later
ruby '>= 2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.6'
# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.5', '>= 0.5.4'
# Use Puma as the app server
gem 'puma', '~> 6.4'
# Sprockets 4 reads app/assets/config/manifest.js (required for importmap assets)
# (Rails 7.0 no longer depends on sprockets-rails, so it must be listed here)
gem 'sprockets-rails'
gem 'sprockets', '~> 4.0'
# Tailwind CSS via the standalone binary (no Node required)
gem 'tailwindcss-rails', '~> 2.0'
# Hotwire: import maps for JavaScript and Turbo for page navigation
# (importmap-rails 2.x requires Ruby 3.1+, so 1.x is pinned for now.
#  turbo-rails must be 2.x: Turbo 7 misjudges this app's URLs, whose
#  IDs end in domain names like .com, as non-HTML and skips them)
gem 'importmap-rails', '~> 1.2'
gem 'turbo-rails', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'dovecot_crammd5'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.16', require: false

group :development, :test do
  gem 'pry-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '~> 4.0'
  gem 'listen', '~> 3.3'
end

group :test do
  # System tests run against headless Chromium installed in the Docker image
  gem 'capybara'
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
