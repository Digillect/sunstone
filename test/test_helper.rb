$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

#require 'sunstone'
require 'bundler/setup'

Bundler.require(:default, :test)

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/great_expectations'

require 'assertions'

MiniTest::Reporters.use!

#Sunstone.eager_load!
