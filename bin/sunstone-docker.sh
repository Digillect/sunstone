#!/bin/sh
export BUNDLE_GEMFILE=/usr/local/sunstone/Gemfile

/usr/bin/env ruby /usr/local/sunstone/lib/sunstone.rb $*
