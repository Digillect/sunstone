require 'sunstone/objects/base_object'
require 'sunstone/objects/handler'

module Sunstone
  module Objects
    class Lifecycle < BaseObject
      property :post_start, Handler
      property :pre_stop, Handler
    end
  end
end
