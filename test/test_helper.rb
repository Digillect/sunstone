require 'bundler/setup'

Bundler.require(:default, :test)

require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir File.expand_path('../lib', File.dirname(__FILE__))
loader.setup # ready!

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/great_expectations'

require 'active_support'
require 'active_support/core_ext'

require 'assertions'

#MiniTest::Reporters.use!
