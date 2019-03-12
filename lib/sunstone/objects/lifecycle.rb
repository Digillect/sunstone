require 'sunstone/objects/base_object'
require 'sunstone/objects/handler'

module Sunstone
  module Objects
    class Lifecycle < BaseObject
      property :post_start, readonly: true
      property :pre_stop, readonly: true

      def initialize
        super

        @post_start = Handler.new
        @pre_stop = Handler.new
      end

      def empty?
        @post_start.empty? && @pre_stop.empty?
      end
    end
  end
end
