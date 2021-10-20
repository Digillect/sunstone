#!/bin/sh
export BUNDLE_GEMFILE=/usr/local/sunstone/gems.rb

/usr/bin/env ruby /usr/local/sunstone/lib/sunstone.rb $*
