#!/bin/sh

SUNSTONE_DIR=/usr/local/sunstone

export BUNDLE_GEMFILE=$SUNSTONE_DIR/gems.rb

/usr/bin/env ruby $SUNSTONE_DIR/sunstone.rb $*
