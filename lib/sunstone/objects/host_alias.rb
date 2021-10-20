module Sunstone
  module Objects
    class HostAlias < BaseObject
      property :host_names, Array, String, initialize: false, serialized_name: 'hostnames'
      property :ip, String

      def initialize(ip, host_names = nil)
        super()

        @ip = ip
        @host_names = host_names || []
      end
    end
  end
end
