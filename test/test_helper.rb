$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'sunstone'
require 'bundler/setup'

Bundler.require(:default, :test)

require 'minitest/autorun'
require 'minitest/reporters'

MiniTest::Reporters.use!

Sunstone.eager_load!
