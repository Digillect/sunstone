require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class ContainerPort < BaseObject
      property :container_port, readonly: true
      property :name, readonly: true
      property :host_ip, readonly: true, serialized_name: :hostIP
      property :host_port, readonly: true
      property :protocol, readonly: true

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
