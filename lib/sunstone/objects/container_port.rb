module Sunstone
  module Objects
    class ContainerPort
      attr_reader :container_port, :host_ip, :host_port, :name, :protocol

      def initialize(container_port, host_ip: nil, host_port: nil, name: nil, protocol: nil)
        @container_port = container_port
        @host_ip = host_ip
        @host_port = host_port
        @name = name
        @protocol = protocol
      end

      def to_hash
        result = { containerPort: @container_port }

        result[:name] = @name.to_s unless @name.blank?
        result[:hostIP] = @host_ip.to_s unless @host_ip.blank?
        result[:hostPort] = @host_port unless @host_port.blank?
        result[:protocol] = @protocol.to_s unless @protocol.blank?

        result
      end
    end
  end
end
