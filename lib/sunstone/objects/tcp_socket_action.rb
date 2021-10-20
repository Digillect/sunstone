module Sunstone
  module Objects
    class TcpSocketAction < BaseObject
      property :port
      property :host, String

      def initialize(port, host = nil)
        super()

        @port = port
        @host = host
      end
    end
  end
end
