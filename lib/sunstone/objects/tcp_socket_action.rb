module Sunstone
  module Objects
    class TcpSocketAction
      attr_reader :host, :port

      def initialize(port, host = nil)
        @host = host
        @port = port
      end

      def to_hash
        result = { port: @port }

        result[:host] = @host.to_s if @host

        result
      end
    end
  end
end
