$LOAD_PATH.unshift __dir__

require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'sunstone/main'

Sunstone.run

