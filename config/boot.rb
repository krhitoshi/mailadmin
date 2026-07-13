# concurrent-ruby 1.3.5+ no longer requires logger, which breaks
# ActiveSupport on Rails < 7.1 with an uninitialized constant Logger error
require 'logger'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
