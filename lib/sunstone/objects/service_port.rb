require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ServicePort < BaseObject
      property :port, Integer
      property :name, String
      property :node_port, Integer
      property :protocol, String
      property :target_port

      def initialize(port, name = nil, node_port = nil, protocol = nil, target_port = nil)
        super()

        @port = port
        @name = name
        @node_port = node_port
        @protocol = protocol
        @target_port = target_port
      end
    end
  end
end
