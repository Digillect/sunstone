require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir File.expand_path('lib', File.dirname(__FILE__))
loader.setup # ready!

runner = Sunstone::Runner.new

runner.run

