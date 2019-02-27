require 'sunstone/objects/base_object'

module Sunstone
  module Objects
    class TcpSocketAction < BaseObject
      property :port
      property :host

      def initialize(port, host = nil)
        super()

        @port = port
        @host = host
      end
    end
  end
end
