# concurrent-ruby 1.3.5 以降が logger を require しなくなったため明示的に読み込む
# (Rails 7.1 未満では ActiveSupport が Logger 未定義でエラーになる)
require 'logger'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
