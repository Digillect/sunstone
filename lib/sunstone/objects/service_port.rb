module Sunstone
  module Objects
    class ServicePort
      attr_reader :name, :node_port, :port, :protocol, :target_port

      def initialize(port, name = nil, node_port = nil, protocol = nil, target_port = nil)
        @port = port
        @name = name
        @node_port = node_port
        @protocol = protocol
        @target_port = target_port
      end

      def to_hash
        result = { port: @port }

        result[:name] = @name.to_s unless @name.blank?
        result[:nodePort] = @node_port unless @node_port.blank?
        result[:protocol] = @protocol unless @protocol.blank?
        result[:targetPort] = @target_port unless @target_port.blank?

        result
      end
    end
  end
end
