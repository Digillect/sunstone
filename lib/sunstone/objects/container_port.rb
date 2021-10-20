module Sunstone
  module Objects
    class ContainerPort < BaseObject
      property :container_port, Integer, readonly: true
      property :name, String
      property :host_ip, String, serialized_name: :hostIP
      property :host_port, Integer
      property :protocol, String

      def initialize(container_port, host_ip: nil, host_port: nil, name: nil, protocol: nil)
        super()

        @container_port = container_port
        @host_ip = host_ip
        @host_port = host_port
        @name = name
        @protocol = protocol
      end
    end
  end
end
