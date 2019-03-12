require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class HostAlias < BaseObject
      property :host_names, readonly: true, serialized_name: 'hostnames'
      property :ip

      def initialize(ip, host_names = nil)
        super()

        @host_names = host_names || []
        @ip = ip
      end
    end
  end
end
