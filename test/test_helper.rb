$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'bundler/setup'

Bundler.require(:default, :test)

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/great_expectations'

require 'active_support'
require 'active_support/core_ext'

require 'assertions'

MiniTest::Reporters.use!
